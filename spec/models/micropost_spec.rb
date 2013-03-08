require 'spec_helper'

describe Micropost do
	before(:each) do
		@user = Factory(:user)
		@attr = { :content => "Contenu du message" }
	end
	
	it "devrait creer une nouvelle instance avec les attributs valides" do
		@user.microposts.create!(@attr)
	end
	
	describe "associations avec l'utilisateur" do
		
		before(:each) do
			@micropost = @user.microposts.create(@attr)
		end
		
		it "devrait avoir un attribut user" do
			@micropost.should respond_to(:user)
		end
		
		it "devrait avoir le bon utilisateur associe" do
			@micropost.user_id.should == @user.id
			@micropost.user.should == @user
		end
		
	end

	describe "validations" do
		it "requiert un identifiant d'utilisateur" do
			Micropost.new(@attr).should_not be_valid
		end
		
		it "requiert un contenu non vide" do
			@user.microposts.build(:content => " ").should_not be_valid
		end
		
		it "devrait rejeter un contenu trop long" do
			@user.microposts.build(:content => "a"*141).should_not be_valid
		end
	end
	
	describe "from users followed by" do
		before(:each) do
			@other_user = Factory(:user, :email => Factory.next(:email))
			@third_user = Factory(:user, :email => Factory.next(:email))
			
			@user_post = @user.microposts.create!(:content => "foo")
			@other_post = @other_user.microposts.create!(:content => "bar")
			@third_post = @third_user.microposts.create!(:content => "baz")
			
			@user.follow!(@other_user)
		end
		
		it "devrait avoir une methode de classe from_users_followed_by" do
			Micropost.should respond_to(:from_users_followed_by)
		end
		
		it "devrait inclure les messages des utilisateurs suivis" do
			Micropost.from_users_followed_by(@user).should include(@other_post)
		end
		
		it "devrait inclure les messages de l'utilisateur" do
			Micropost.from_users_followed_by(@user).should include(@user_post)
		end
		
		it "ne devrait pas inclure les messages des utilisateurs non suivis" do
			Micropost.from_users_followed_by(@user).should_not include(@third_post)
		end
	end
end
