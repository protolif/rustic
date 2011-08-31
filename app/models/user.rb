# == Schema Information
#
# Table name: users
#
#  id                 :integer(4)      not null, primary key
#  fname              :string(255)
#  lname              :string(255)
#  email              :string(255)
#  tel                :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#  admin              :boolean(1)      default(FALSE)
#  address            :string(255)
#  city               :string(255)
#  state              :string(255)
#  zip                :string(255)
#

require 'digest'

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :fname, :lname, :email, :tel, :tel2,
                  :address, :city, :state, :zip,
                  :password, :password_confirmation
  
  has_many :computers, :dependent   => :destroy
  has_many :tickets,   :dependent   => :destroy,
                       :foreign_key => "customer_id"
  has_many :jobs,      :dependent   => :destroy,
                       :foreign_key => "technician_id",
                       :class_name  => "Ticket" 
  
  email_regex    = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  password_regex = /^.*(?=.{8,})(?=.*[a-z])(?=.*[A-Z])(?=.*[\d\W]).*$/
  
  validates :fname,   :presence   => true, :length => { :maximum => 20 }
  validates :lname,   :presence   => true, :length => { :maximum => 20 }
  validates :tel,     :presence   => true, :length => { :within => 10..22 }
  validates :tel2,    :allow_nil  => true, :length => { :within => 10..22 }
  validates :email,   :presence   => true,
                      :format     => { :with => email_regex },
                      :uniqueness => { :case_sensitive => false }

  validates :password, :presence     => true,
                       :confirmation => true,
                       :format       => { :with => password_regex,
                                          :message => "does not meet complexity requirements." },
                       :on           => :create
  
  validates :password, :allow_nil    => true,
                       :confirmation => true,
                       :format       => { :with => password_regex,
                                          :message => "does not meet complexity requirements." },
                       :on           => :update
  
  before_save :encrypt_password
  before_save :transform_data
  
  ST = ["AK","AL","AR","AS","AZ","CA","CO","CT","DC","DE","FL","GA","GU","HI","IA",
        "ID","IL","IN","KS","KY","LA","MA","MD","ME","MH","MI","MN","MO","MS","MT",
        "NC","ND","NE","NH","NJ","NM","NV","NY","OH","OK","OR","PA","PR","PW","RI",
        "SC","SD","TN","TX","UT","VA","VI","VT","WA","WI","WV","WY"]
  
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    (user && user.has_password?(submitted_password)) ? user : nil
  end
  
  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end
  
  def self.search(search, page)
    paginate :per_page => 8, :page => page,
             :conditions => ['lower(lname) like ? or lower(fname) like ?',
                            "%#{search.downcase unless search.nil?}%",
                            "%#{search.downcase unless search.nil?}%"],
             :order => 'lname'
  end
  
  private
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end
    
    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end
    
    def encrypt_password #really works now ^_^
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password) unless self.password.nil?
    end
    
    def transform_data
      self.tel.gsub!(/\D/, "") #strips non-numeric values
      self.tel = self.tel.slice(/\d{10}/) #strips the first 10 digits
      self.fname = self.fname.capitalize
      self.lname = self.lname.capitalize
      unless self.tel2.nil?
        self.tel2.gsub!(/\D/, "") #strips non-numeric values
        self.tel2 = self.tel2.slice(/\d{10}/) #strips the first 10 digits
      end
    end
end