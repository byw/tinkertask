class Item
  include MongoMapper::EmbeddedDocument
  
#  belongs_to :user
  belongs_to :list
  
  key :body, String
  key :position, Integer
  key :complete, Boolean, :default => false
  
  validates_length_of :body, :maximum => 500
  
  def user
    self.list.user
  end
end