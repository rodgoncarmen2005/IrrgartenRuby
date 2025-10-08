#encoding:utf-8

require_relative 'dice'

module Irrgarten

	class Weapon
		
		
		#constructor
		def initialize (power, uses)
			@power = power #float
			@uses = uses #int
		end
		
		#attack
		def attack
			salida = 0.0
			if @uses > 0 then
				@uses -= 1
				salida = @power
			end
			salida #se puede poner return pero es opcional, automáticamente se devuelve la última línea
		end
	
		#discard
		def discard
			Dice.discard_element(@uses)
		end
	
	
		#toString
		def to_s
			"W[#{@power},#{@uses}]"	
		end
	end
end
