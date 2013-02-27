require 'spec_helper'

describe "LayoutLinks" do
  it "devrait trouver une page Accueil a '/'" do
    get '/'
    response.should have_selector('title', :content => "Accueil")
  end

  it "devrait trouver une page Contact a '/contact'" do
    get '/contact'
    response.should have_selector('title', :content => "Contact")
  end

  it "devrait trouver une page A Propos a '/about'" do
    get '/about'
    response.should have_selector('title', :content => "A propos")
  end

  it "devrait trouver une page Aide a '/help'" do
    get '/help'
    response.should have_selector('title', :content => "Aide")
  end
  
  it "devrait trouver une page d'inscription a '/signup'" do
		get '/signup'
		response.should have_selector("title", :content => "Inscription")
  end
end
