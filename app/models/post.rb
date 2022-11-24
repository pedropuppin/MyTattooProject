class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :photo

  def self.group_em(posts, ngroups)
    n_per_group, left_over = posts.size.divmod(ngroups)
    cum_off = 0
    ngroups.times.map do |i|
      n = n_per_group + (i < left_over ? 1 : 0)
      a = posts[cum_off, n]
      cum_off += n
      a
    end
  end
end
