#encoding:utf-8

require_relative 'dice'

module Irrgarten

	class Shield < CombatElement

		# protect --> determina si quedan usos y devuelve la protección del escudo
		def protect
			self.produce_effect
		end

		# toString --> muestra los atributos del escudo
		def to_s
			"S" + super
		end
	end

end
