class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :photo
  has_many :likes, dependent: :destroy
  has_many :taggings
  has_many :tags, through: :taggings

  include PgSearch::Model

  def tag_list
    self.tags.collect do |tag|
      tag.name
    end.join(", ")
  end

  def tag_list=(tags_string)
    tag_names = tags_string.split(",").collect { |s| s.strip.downcase }.uniq
    new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }
    self.tags = new_or_found_tags
  end

  pg_search_scope :search_by_content,
                  against: [:content],
                  using: {
                    tsearch: { prefix: true }
                  },
                  ignoring: :accents

  pg_search_scope :search_by_tag,
                  associated_against: {
                    tags: :name
                  },
                  using: {
                    tsearch: { prefix: true }
                  },
                  ignoring: :accents
end
