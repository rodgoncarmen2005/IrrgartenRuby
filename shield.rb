#encoding:utf-8

require_relative 'combat_element'

module Irrgarten

	class Shield < CombatElement

		public_class_method :new #porque la superclase es abstracta y lo tenia privado, ahora queremos permitir instanciar esta subclase

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
