class Message < ApplicationRecord
  belongs_to :quotation
  belongs_to :user

  validates :content, presence: true
end
