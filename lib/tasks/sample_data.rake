require 'faker'

namespace :db do
	desc "peupler la base de donnees avec des echantillons"
	task :populate => :environment do
		Rake::Task['db:reset'].invoke
		make_users
		make_microposts
		make_relationships
	end
end

def make_users
	admin = User.create!(:nom => "Exemple User",
											 :email => "exemple@rails.org",
											 :password => "password",
											 :password_confirmation => "password")
	admin.toggle!(:admin)
	99.times do |n|
		nom = Faker::Name.name
		email = "exemple-#{n+1}@rails.org"
		password = "foobar"
		User.create!(:nom => nom,
								 :email => email,
								 :password => password,
								 :password_confirmation => password)
	end
end

def make_microposts
	User.all(:limit => 6).each do |user|
		50.times do
			content = Faker::Lorem.sentence(5)
			user.microposts.create!(:content => content)
		end
	end
end

def make_relationships
	users = User.all
	user = users.first
	following = users[1..50]
	followers = users[3..40]
	following.each { |followed| user.follow!(followed) }
	followers.each { |follower| follower.follow!(user) }
end
