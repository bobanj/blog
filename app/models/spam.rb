class Spam < ActiveRecord::Base
  # Attributes
  attr_accessible :name, :email, :website, :content

  # Validations
  validates_presence_of :content

  # Associations
  belongs_to :post

  # Includes
  include Rakismet::Model
  rakismet_attrs :author => :name,
                 :author_email => :email,
                 :author_url => :website

  # Public Methods
  def slice_and_dice(comment)
    self.name =  comment.name
    self.email =   comment.email
    self.website =   comment.website
    self.content =     comment.content
    self.comment_type =   comment.comment_type
    self.permalink =   comment.permalink
    self.user_ip =   comment.user_ip
    self.user_agent =   comment.user_agent
    self.referrer =   comment.referrer
  end
end