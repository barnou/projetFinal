require 'faker'

namespace :db do
	desc "Peupler la bdd"
	task :populate => :environment do
		Rake::Task['db:reset'].invoke
		administrateur = User.create!(:nom => "Exemple Utilisateur",
								 :email => "exemple@projet.com",
								 :password => "password",
								 :password_confirmation => "password")
		administrateur.toggle!(:admin)
		99.times do |n|
			nom = Faker::Name.name
			email = "exemple-#{n+1}@railstutorial.org"
			password = "motdepasse"
			User.create!(:nom => nom,
									 :email => email,
									 :password => password,
									 :password_confirmation => password)
		end
	end
end
