#encoding:utf-8

<<<<<<< HEAD
require_relative 'dice'

=======
>>>>>>> d2506f0c24381b620d51da345e0b1f0f144087b2
module Irrgarten

	class Weapon
		
		
		#constructor
		def initialize (power, uses)
			@power = power #float
			@uses = uses #int
		end
		
		#attack
<<<<<<< HEAD
		def attack
=======
		def attack ()
>>>>>>> d2506f0c24381b620d51da345e0b1f0f144087b2
			salida = 0.0
			if @uses > 0 then
				@uses -= 1
				salida = @power
			end
			salida #se puede poner return pero es opcional, automáticamente se devuelve la última línea
		end
	
		#discard
<<<<<<< HEAD
		def discard
			Dice.discard_element(@uses)
=======
		def discard ()
			salida = element_discard(@uses);
			salida
>>>>>>> d2506f0c24381b620d51da345e0b1f0f144087b2
		end
	
	
		#toString
<<<<<<< HEAD
		def to_s
=======
		def to_s ()
>>>>>>> d2506f0c24381b620d51da345e0b1f0f144087b2
			"W[#{@power},#{@uses}]"	
		end
	end
end
