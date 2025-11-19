#encoding:utf-8

require_relative 'combat_element'

module Irrgarten

	class Weapon < CombatElement

		public_class_method :new #porque la superclase es abstracta y lo tenia privado, ahora queremos permitir instanciar esta subclase

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
