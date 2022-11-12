class Quotation < ApplicationRecord
  belongs_to :user
  SIZES = ['Small', 'Medium', 'Large']
end
