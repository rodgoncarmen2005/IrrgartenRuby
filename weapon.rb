#encoding:utf-8

require_relative 'dice'

module Irrgarten

	class Weapon < CombatElement


		# attack --> determina si quedan usos y devuelve la potencia del arma
		def attack
			self.produce_effect
		end

		# toString --> muestra los atributos del arma
		def to_s
			"W" + super
		end
	end

end
