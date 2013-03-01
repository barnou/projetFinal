require 'spec_helper'

describe Relationship do

	let(:follower) { Factory(:user) }
	let(:followed) { Factory(:user,:email => Factory.next(:email)) }
	let(:relationship) { follower.relationships.build(followed_id: followed.id) }

	subject { relationship }
	
	it { should be_valid }
	
	describe "attribut accessible" do
		it "ne devrait pas permettre d'acceder a 'follower_id'" do
			expect do
				Relationship.new(follower_id: follower.id)
			end
		end
	end

	describe "followers methodes" do
		it { should respond_to(:follower) }
		it { should respond_to(:followed) }
		its(:follower) { should == follower }
		its(:followed) { should == followed }
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
