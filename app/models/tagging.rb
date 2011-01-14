class Tagging < ActiveRecord::Base
  # Associations
  belongs_to :post
  belongs_to :tag
end
