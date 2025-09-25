#encoding:utf-8

require_relative 'Weapon'
require_relative 'Shield'

module Irrgarten

	class Irrgarten
		
		module Directions
			LEFT = :left
			RIGHT = :right
			UP = :up
			DOWN = :down
		end	
		
		module Orientation
			VERTICAL = :vertical
			HORIZONTAL = :horizontal
		end	
	
		module GameCharacter
			PLAYER = :player
			MONSTER = :monster
		end
	

		def self.prueba_weapon
			
			w = Weapon.new(2.0, 3)
			puts w.to_s
			4.times do
				puts "Potencia de disparo #{w.attack}" 
				puts w.to_s
			end
	
		end
		
		def self.prueba_shield
			
			s = Shield.new(2.0, 3)
			puts s.to_s
			4.times do
				puts "Usamos escudo con protección #{s.protect}" 
				puts s.to_s
			end
	
		end
	
	end
	
	Irrgarten.prueba_weapon
	Irrgarten.prueba_shield
	
end

Irrgarten::Irgarten.prueba_weapon
Irrgarten::Irgarten.prueba_shield
