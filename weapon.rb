#encoding:utf-8

require_relative 'dice'

module Irrgarten

	class Weapon

		# Constructor
		def initialize(power, uses)
			@power = power  # Float
			@uses = uses    # Integer
		end

		# attack --> determina si quedan usos y devuelve la potencia del arma
		def attack
			salida = 0.0
			if @uses > 0
				@uses -= 1
				salida = @power
			end
			salida
		end

		# discard --> devuelve si se desecha el arma apoyandose en Dice.dicard_element
		def discard
			Dice.discard_element(@uses)
		end

		# toString --> muestra los atributos del arma
		def to_s
			"W[#{@power},#{@uses}]"
		end
	end

end
