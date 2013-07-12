class User < ActiveRecord::Base  
  has_many :computers, :dependent   => :destroy
  has_many :tickets,   :dependent   => :destroy,
                       :foreign_key => "customer_id"
  has_many :jobs,      :dependent   => :destroy,
                       :foreign_key => "technician_id",
                       :class_name  => "Ticket" 
  
  email_regex    = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :fname,   :presence   => true, :length => { :maximum => 20 }
  validates :lname,   :presence   => true, :length => { :maximum => 20 }
  validates :tel,     :presence   => true, :length => { :within => 10..22 }
  validates :tel2,    :allow_nil  => true, :length => { :within => 10..22 }
  validates :email,   :presence   => true,
                      :format     => { :with => email_regex },
                      :uniqueness => { :case_sensitive => false }

  validates :password, :presence     => true,
                       :confirmation => true,
                       :length       => { :within => 6..20 },
                       :on           => :create
  
  validates :password, :allow_nil    => true,
                       :confirmation => true,
                       :length       => { :within => 6..20 },
                       :on           => :update
  
  before_save :transform_data
  
  ST = ["AK","AL","AR","AS","AZ","CA","CO","CT","DC","DE","FL","GA","GU","HI","IA",
        "ID","IL","IN","KS","KY","LA","MA","MD","ME","MH","MI","MN","MO","MS","MT",
        "NC","ND","NE","NH","NJ","NM","NV","NY","OH","OK","OR","PA","PR","PW","RI",
        "SC","SD","TN","TX","UT","VA","VI","VT","WA","WI","WV","WY"]
  
  private
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