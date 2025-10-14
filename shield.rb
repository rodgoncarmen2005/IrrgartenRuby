#encoding:utf-8

<<<<<<< HEAD
require_relative 'dice'

=======
>>>>>>> d2506f0c24381b620d51da345e0b1f0f144087b2
module Irrgarten

	class Shield
		
		
		#constructor
		def initialize (protection, uses)
			@protection = protection #float
			@uses = uses #int
		end
		
		#protect
<<<<<<< HEAD
		def protect
=======
		def protect ()
>>>>>>> d2506f0c24381b620d51da345e0b1f0f144087b2
			salida = 0.0
			if @uses > 0 then
				@uses -= 1
				salida = @protection
			end
			salida #se puede poner return pero es opcional, automáticamente se devuelve la última línea
		end
		
		#discard
		def discard ()
<<<<<<< HEAD
			Dice.discard_element(@uses);
=======
			salida = element_discard(@uses);
			salida
>>>>>>> d2506f0c24381b620d51da345e0b1f0f144087b2
		end
		
		#toString
		def to_s ()
			"S[#{@protection},#{@uses}]"
		end
	end
end
