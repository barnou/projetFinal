require 'spec_helper'

describe Relationship do
	before(:each) do
		@follower = Factory(:user)
		@followed = Factory(:user, :email => Factory.next(:email))
		
		@relationship = @follower.relationships.build(:followed_id => @followed.id)
	end
	
	it "devrait creer une nouvelle instance en donnant des attributs valides" do
		@relationship.save!
	end
	
	describe "attribut accessible" do
		it "ne devrait pas permettre d'acceder a 'follower_id'" do
			expect do
				Relationship.new(follower_id: follower.id)
			end
			
	describe "Methode de suivi" do
		before(:each) do
			@relationship.save
		end
		
		it "devrait avoir un attribut follower(lecteur)" do
			@relationship.should respond_to(:follower)
		end
		
		it "devrait avoir le bon lecteur" do
			@relationship.follower.should == @follower
		end
		
		it "devrait avoir le bon utilisateur suivi (auteur)" do
			@relationship.followed.should == @followed
		end
	end

	describe "validations" do
		it "devrait exiger un attribut follower_id" do
			@relationship.follower_id = nil
			@relationship.should_not be_valid
		end
		
		it "devrait exiger un attribut followed_id" do
			@relationship.followed_id = nil
			@relationship.should_not be_valid
		end
	end

	describe "quand 'followed_id' n'est pas present" do
		before { relationship.followed_id = nil }
		it { should_not be_valid }
	end
	
	describe "quand 'follower_id' n'est pas present" do
		before { relationship.follower_id = nil }
		it { should_not be_valid }
	end
end
