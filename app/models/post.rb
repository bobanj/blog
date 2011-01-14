class Post < ActiveRecord::Base
  # Attributes
  attr_accessible :title, :content, :markdown, :author, :commentable, :tag_names
  attr_writer :tag_names

  # Validations
  validates_presence_of :title, :content

  # Associations
  has_many :comments, :dependent => :destroy
  has_many :spams, :dependent => :destroy
  has_many :taggings, :dependent => :destroy
  has_many :tags, :through => :taggings

  # Callbacks
  after_save :assign_tags

  # Public methods
  def to_param
    "#{id}-#{title.parameterize}"
  end

  def tag_names
    @tag_names || tags.map{|t| t.name}.join(' ') # it seems like factory girl somehow can't handle tags.map(&name).join(' ')
  end

  # Private methods
  private

  def assign_tags
    if @tag_names
      self.tags = @tag_names.split(/\s+/).map do |name|
        Tag.find_or_create_by_name(name.strip)
      end
    end
  end
end
