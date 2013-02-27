require 'spec_helper'

describe PagesController do
	render_views

  describe "GET 'home'" do
    it "should be successful" do
      get :home
      response.should be_success
    end
    
    it "devrait avoir le bon titre" do
			get :home
			response.should have_selector("title",
													:content => "Projet RoR Arnou Baptiste | Accueil")
    end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get :contact
      response.should be_success
    end
    
    it "devrait avoir le bon titre" do
			get :contact
			response.should have_selector("title",
													:content => "Projet RoR Arnou Baptiste | Contact")
    end
  end
  
  describe "GET 'about'" do
		it "devrait reussir" do
			get :about
			response.should be_success
		end
		
		it "devrait avoir le bon titre" do
			get :about
			response.should have_selector("title",
													:content => "Projet RoR Arnou Baptiste | A propos")
    end
  end
  
  describe "GET 'help'" do
		it "devrait reussir" do
			get :help
			response.should be_success
		end
		
		it "devrait avoir le bon titre" do
			get :help
			response.should have_selector("title",
													:content => "Projet RoR Arnou Baptiste | Aide")
    end
  end

end
