class PostSerializer < Pinkman::Serializer::Base
  
  has_many :comments
  
  scope :public do |can|
    can.read_attributes :all, :comments
    can.write_attributes :all
    can.access_actions :all
  end
  
end