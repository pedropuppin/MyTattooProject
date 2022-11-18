class Address < ApplicationRecord
  belongs_to :user, optional: true

  validates :zipcode, :country, :city, presence: true
end
