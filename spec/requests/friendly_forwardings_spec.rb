require 'spec_helper'

describe "FriendlyForwardings" do
 
 it "devrait rediriger vers la page voulue apres identification" do
	user = Factory(:user)
	visit edit_user_path(user)
	fill_in :email, :with => user.email
	fill_in "Mot de passe", :with => user.password
	click_button
	response.should render_template('users/edit')
 end
end
