class Tag < ApplicationRecord
  has_many :taggings
  has_many :posts, through: :taggings

  include PgSearch::Model
  
  def to_s
    name.capitalize
  end

  pg_search_scope :search_by_name,
  against: [ :name ],
  using: {
    tsearch: { prefix: true }
  }

  TAG = ['Black & Gray', 'Blackwork', 'Chicano', 'Dotwork', 'Fineline', 'Geometric', 'Hand-Poked', 'Dark Art', 'Japanese (Irezumi)', 'Lettering',
    'Neo Traditional', 'New School', 'Ornamental', 'Realism', 'Illustrative', 'Old School (Traditional)', 'Trash Polka Style',
    'Tribal', 'Watercolor', 'Surrealism', 'Cosmetic', 'Ignorant']
end
