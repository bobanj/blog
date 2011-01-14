class Tag < ActiveRecord::Base
  # Associations
  has_many :taggings, :dependent => :destroy
  has_many :posts, :through => :taggings

  # Scopes
  scope :tag_words, select('tags.id, tags.name, COUNT(*) as count').
      joins(:taggings => :post).
      group('tags.name').
      order('name').
      limit(30)

  # Public methods
  def to_param
    name.parameterize
  end
end
