class Draft < ActiveRecord::Base
  # Attributes
  attr_accessible :title, :content, :markdown, :author

  # Validations
  validates_presence_of :title, :content

  # Public methods
  def to_param
    "#{id}-#{title.parameterize}"
  end
end
