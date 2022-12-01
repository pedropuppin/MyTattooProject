class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :photo
  has_many :likes, dependent: :destroy
end
