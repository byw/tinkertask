class List
  include MongoMapper::Document
  
  belongs_to :user
  has_many :items
  
  key :name, String, :required => true
  key :position, Integer
  key :user_id, ObjectId
  
  def active_items_count
    count = 0
    items.each {|i| count += 1 unless i.complete}
    count
  end
  
end
