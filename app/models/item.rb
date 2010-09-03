class Item
  include MongoMapper::EmbeddedDocument
  
#  belongs_to :user
  belongs_to :list
  
  key :body, String
  key :position, Integer
  key :complete, Boolean, :default => false
  
  def user
    self.list.user
  end
end