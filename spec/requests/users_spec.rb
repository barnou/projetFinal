require 'spec_helper'

describe "Users" do
  describe "une inscription" do
		describe "ratee" do
			it "ne devrait pas creer un nouvel utilisateur" do
				lambda do
					visit signup_path
					fill_in "nom",														:with => ""
					fill_in "email",													:with => ""											
					fill_in "Mot de passe",								 		:with => ""
					fill_in "Confirmation du mot de passe",		:with => ""
					click_button
					response.should render_template('users/new')
					response.should have_selector("div#error_explanation")
				end.should_not change(User,:count)
			end
		end
  
		describe "reussie" do
			it "devrait creer un nouvel utilisateur" do
				lambda do
					visit signup_path
					fill_in "nom",														:with => "Arnou Baptiste"
					fill_in "email",													:with => "b.arnou05@gmail.com"											
					fill_in "Mot de passe",								 		:with => "ce1mdpp"
					fill_in "Confirmation du mot de passe",		:with => "ce1mdpp"
					click_button
					response.should have_selector("div.flash.success", :content => "Vous avez bien ete enregistre")
					response.should render_template('users/show')
				end.should change(User, :count).by(1)
			end
		end
  end

	describe "connexion/deconnexion" do
		
		describe "echec" do
			
			it "ne devrait pas identifier l'utilisateur" do
				visit signin_path
				fill_in "email",				:with => ""
				fill_in "Mot de passe",	:with => ""
				click_button
				response.should have_selector("div", :content => "Combinaison email/mot de passe invalide.")
			end
		end
		
		describe "succes" do
			
			it "devrait identifier un utilisateur puis le deconnecter" do
				user = Factory(:user)
				visit signin_path
				fill_in "email",				:with => user.email
				fill_in "Mot de passe",	:with =>user.password
				click_button
				controller.should be_signed_in
				click_link "Deconnexion"
				controller.should_not be_signed_in
			end
		end
	end
end
