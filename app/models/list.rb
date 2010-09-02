class List
  include MongoMapper::Document
  
  belongs_to :user
  has_many :items
  
  key :name, String, :required => true
  key :position, Integer
  
end
