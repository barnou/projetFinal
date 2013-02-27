module ApplicationHelper

	def titre
		titre_de_base = "Projet RoR Arnou Baptiste"
		if @titre.nil?
			titre_de_base
		else
			"#{titre_de_base} | #{@titre}"
		end
	end

	def logo
		  logo = image_tag("logo.png", :alt => "Application exemple", :class => "round")
	end
end
