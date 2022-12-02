class Tag < ApplicationRecord
  has_many :taggings
  has_many :posts, through: :taggings

  def to_s
    name.capitalize
  end

  TAG = ['Black & Gray', 'Blackwork', 'Chicano', 'Dotwork', 'Fineline', 'Geometric', 'Hand-Poked', 'Dark Art', 'Japanese (Irezumi)', 'Lettering',
    'Neo Traditional', 'New School', 'Ornamental', 'Realism', 'Illustrative', 'Old School (Traditional)', 'Trash Polka Style',
    'Tribal', 'Watercolor', 'Surrealism', 'Cosmetic', 'Ignorant']
end
