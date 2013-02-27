require 'spec_helper'

describe User do
	before(:each) do
		@attr = { 
			:nom => "Baptiste Arnou", 
			:email => "b.arnou05@gmail.com",
			:password => "ce1mdpp",
			:password_confirmation => "ce1mdpp"
			}
	end
	
	it "devrait creer une nouvelle instance dotee d'attributs valides" do
		User.create!(@attr)
	end
	
	it "devrait exiger un nom" do
		bad_guy = User.new(@attr.merge(:nom => ""))
		bad_guy.should_not be_valid
	end
	
	it "exige une adresse email" do
		no_email_user = User.new(@attr.merge(:email =>""))
		no_email_user.should_not be_valid
	end
	
	it "devrait rejeter les noms trop long" do
		long_nom = "a"*51
		long_nom_user = User.new(@attr.merge(:nom => long_nom))
		long_nom_user.should_not be_valid
	end
	
	it "devrait accepter une adresse email valide" do
    adresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    adresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it "devrait rejeter une adresse email invalide" do
    adresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    adresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end
  
  it "devrait rejeter un email double" do
		User.create!(@attr)
		user_with_duplicate_email = User.new(@attr)
		user_with_duplicate_email.should_not be_valid
  end
  
  it "devrait rejeter une adresse email invalide jusqu'a la casse" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  
  
	describe "password validations" do
		
		it "devrait exiger un mot de passe" do
			User.new(@attr.merge(:password => "", :password_confirmation => "")).should_not be_valid
		end
		
		it "devrait exiger une confirmation du mot de passe qui correspond" do
			User.new(@attr.merge(:password_confirmation => "invalid")).should_not be_valid
		end
		
		it "devrait rejeter les mots de passes (trop) courts" do
			short = "a"*5
			hash = @attr.merge(:password => short, :password_confirmation => short)
			User.new(hash).should_not be_valid
		end
		
		it "devrait rejeter les mots de passes (trop) longs" do
			long = "a"*41
			hash = @attr.merge(:password => long, :password_confirmation => long)
			User.new(hash).should_not be_valid
		end
  end

	describe "password encryption" do
		before(:each) do
			@user = User.create!(@attr)
		end
		
		it "devrait avoir un attribut mot de passe crypte" do
			@user.should respond_to(:encrypted_password)
		end
		
		it "devrait definir le mot de passe crypte" do
			@user.encrypted_password.should_not be_blank
		end
		
		describe "Methode has_password?" do
			it "doit retourner true si les mots de passes coincident" do
				@user.has_password?(@attr[:password]).should be_true
			end
			
			it "doit retourner faux si les mots de passes divergent" do
				@user.has_password?("invalide").should be_false
			end
		end
	
		describe "Methode d'authentification" do
			it "devrait retourner nul en cas d'inequation entre email/mdp" do
				wrong_password_user = User.authenticate(@attr[:email],"wrongpassword")
				wrong_password_user.should be_nil
			end
			
			it "devrait retourner nul quand un email ne correspond a aucun utilisateur" do
				non_existent_user = User.authenticate("bar@foo.com", @attr[:password])
				non_existent_user.should be_nil
			end
			
			it "devrait retourner l'utilisateur si email/mdp correspondent" do
				matching_user = User.authenticate(@attr[:email],@attr[:password])
				matching_user.should == @user
			end
		end
	end

end
