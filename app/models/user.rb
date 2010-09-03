class User
  include MongoMapper::Document
  
  has_many :lists, :order => "position ASC"
  has_many :items
  
  key :username, String, :index => true, :unique => true, :required => true
  key :crypted_password, String
  key :salt, String
  attr_accessor :password, :password_confirmation
  
  validates_confirmation_of :password
  
  def password=(pw)
    unless pw.blank?
      self.salt = User.generate_salt
      self.crypted_password = User.encrypt_password(pw, self.salt)
      @password = pw
    end
  end
  
  def self.generate_salt
    [Array.new(6){rand(256).chr}.join].pack("m").chomp
  end
  
  def self.encrypt_password(pass, saline)
    Digest::SHA256.hexdigest(pass + "bompalompalomp" + saline)
  end
  
  def self.authenticate(login, pass)
    if user = User.find_by_username(login)
      if user.crypted_password == User.encrypt_password(pass, user.salt)
        return user
      end
    end
  end
end
