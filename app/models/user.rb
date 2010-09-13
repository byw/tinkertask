class User
  include MongoMapper::Document
  
  has_many :lists, :order => "position ASC"
  has_many :items
  
  key :username, String, :unique => true, :required => true
  key :crypted_password, String
  key :salt, String
  key :email, String
  attr_accessor :password, :password_confirmation
  
  EMAIL_MATCHER = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_length_of :username, :within => 2..100, :message => 'should be 2 to 100 characters long'
  validates_format_of :username, :with => /^[a-z|0-9|-]+$/, :message => 'can only contain letters, numbers, and -'
  validates_length_of :password, :within => 5..100, :message => 'should be 5 to 100 characters long', :allow_blank => true
  validates_confirmation_of :password, :allow_blank => true
  validates_format_of :email, :with => EMAIL_MATCHER, :allow_blank => true, :message => "please enter a valid email"
  
  def password=(pw)
    unless pw.blank?
      self.salt = User.generate_salt
      self.crypted_password = User.encrypt_password(pw, self.salt)
      @password = pw
    end
  end
  
  def cookie_code
    Digest::SHA1.hexdigest(self.username)[4,18]
  end
  
  def self.generate_salt
    [Array.new(6){rand(256).chr}.join].pack("m").chomp
  end
  
  def self.encrypt_password(pass, saline)
    Digest::SHA256.hexdigest(pass + "iampopeyethesailormanhoothoot" + saline)
  end
  
  def self.authenticate(login, pass)
    if user = User.find_by_username(login)
      if user.crypted_password == User.encrypt_password(pass, user.salt)
        return user
      end
    end
  end
  
end
