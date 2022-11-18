class Message < ApplicationRecord
  belongs_to :quotation
  belongs_to :user
end
