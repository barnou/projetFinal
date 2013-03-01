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
			end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
		end
	end

	describe "followers methodes" do
		it { should respond_to(:follower) }
		it { should respond_to(:followed) }
		its(:follower) { should == follower }
		its(:followed) { should == followed }
	end
end