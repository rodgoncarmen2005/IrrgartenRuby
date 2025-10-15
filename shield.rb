#encoding:utf-8

require_relative 'dice'

module Irrgarten

	class Shield

		# Constructor
		def initialize(protection, uses)
			@protection = protection  # Float
			@uses = uses              # Integer
		end

		# protect --> determina si quedan usos y devuelve la protección del escudo
		def protect
			salida = 0.0
			if @uses > 0
				@uses -= 1
				salida = @protection
			end
			salida
		end

		# discard --> devuelve si se desecha el escudo apoyandose en Dice.discard_element
		def discard
			Dice.discard_element(@uses)
		end

		# toString --> muestra los atributos del escudo
		def to_s
			"S[#{@protection},#{@uses}]"
		end
	end

end
