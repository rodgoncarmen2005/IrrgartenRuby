#encoding:utf-8

require_relative 'weapon'
require_relative 'shield'
require_relative 'directions'
require_relative 'orientation'
require_relative 'game_character'
require_relative 'game_state'

module Irrgarten

	class Irrgarten
		
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
		
		def self.prueba_game_state
			laberinto = "Laberinto prueba"
			jugadores = "j1, j2"
			monstruos = "araña, ogro"
			numjugadores = 2
			ganador = false
			historia = "nada"
			
			gs= GameState.new(laberinto, jugadores, monstruos, numjugadores , ganador, historia)
			puts "Labyrinth: #{gs.labyrinth}"
			puts "Players: #{gs.players}"
			puts "Monsters: #{gs.monsters}"
			puts "Current Player: #{gs.currentPlayer}"
			puts "Winner: #{gs.winner}"
			puts "Log: #{gs.log}"
		end
	end
	
	Irrgarten.prueba_weapon
	Irrgarten.prueba_shield
	Irrgarten.prueba_game_state
	
end

#Irrgarten::Irgarten.prueba_weapon
#Irrgarten::Irgarten.prueba_shield
