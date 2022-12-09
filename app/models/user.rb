class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  has_one :address, dependent: :destroy
  has_one_attached :photo
  has_many :quotations, dependent: :destroy
  has_many :messages
  has_many :likes, dependent: :destroy
  has_many :posts

  validates :first_name, :last_name, :role, :email, presence: true
  validates :email, uniqueness: true

  include PgSearch::Model

  def self.find_for_facebook_oauth(auth)
    user_params = auth.slice("provider", "uid")
    user_params.merge! auth.info.slice("email", "first_name", "last_name")
    user_params[:facebook_picture_url] = auth.info.image
    user_params[:token] = auth.credentials.token
    user_params[:token_expiry] = Time.at(auth.credentials.expires_at)
    user_params = user_params.to_h

    user = User.find_by(provider: auth.provider, uid: auth.uid)
    user ||= User.find_by(email: auth.info.email) # User did a regular sign up in the past.
    if user
      user.update(user_params)
    else
      user = User.new(user_params)
      user.password = Devise.friendly_token[0, 20]  # Fake password for validation
      user.save
    end

    return user
  end

  def full_name
    [first_name, last_name].join(' ').titleize
  end

  pg_search_scope :search_by_address,
                  associated_against: {
                    address: :city
                  },
                  using: {
                    tsearch: { prefix: true }
                  },
                  ignoring: :accents

  pg_search_scope :search_by_user,
                  against: %i[first_name last_name],
                  using: { tsearch: { prefix: true } },
                  ignoring: :accents
end
