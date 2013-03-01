require 'digest'
class User < ActiveRecord::Base
	attr_accessor :password
	attr_accessible :nom, :email, :password, :password_confirmation
	
	has_many :microposts, :dependent => :destroy
	has_many :relationships, :foreign_key => "follower_id", :dependent => :destroy
	has_many :followed_users, :through => :relationships, :source => :followed
	
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	  
	validates :nom, :presence => true,
									:length => { :maximum => 50 }
									
	validates :email, :presence => true,
										:format => { :with => email_regex },
										:uniqueness => { :case_sensitive => false }
										
	validates :password, :presence => true,
											 :confirmation => true,
											 :length => { :within => 6..40 }
											 
	before_save :encrypt_password
	
	def has_password?(password_soumis)
		encrypted_password == encrypt(password_soumis)
	end
	
	def self.authenticate(email,password_soumis)
		user = find_by_email(email)
		return nil if user.nil?
		return user if user.has_password?(password_soumis)
	end
	
	def self.authenticate_with_salt(id, cookie_salt)
		user = find_by_id(id)
		(user && user.salt == cookie_salt) ? user : nil
	end
	
	def signed_in?
		!current_user.nil?
	end
	
	def feed
		Micropost.where("user_id = ?", id)
	end
	
	def following?(other_user)
		relationships.find_by_followed_id(other_user.id)
	end
	
	def follow!(other_user)
		relationships.create!(:followed_id => other_user.id)
	end
	
	private
	
		def encrypt_password
			self.salt = make_salt if new_record?
			self.encrypted_password = encrypt(password)
		end
		
		def encrypt(string)
			secure_hash("#{salt}--#{string}")
		end
		
		def make_salt
			secure_hash("#{Time.now.utc}--#{password}")
		end
		
		def secure_hash(string)
			Digest::SHA2.hexdigest(string)
		end
end
