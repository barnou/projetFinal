module ApplicationHelper

	def titre
		titre_de_base = "Projet RoR Arnou Baptiste"
		if @titre.nil?
			titre_de_base
		else
			"#{titre_de_base} | #{@titre}"
		end
	end
end
