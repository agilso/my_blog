class Comment < ApplicationRecord
  
  belongs_to :post
  
  default_scope { order("created_at DESC") }
  
  validates :username, :msg, presence: true
  
end
