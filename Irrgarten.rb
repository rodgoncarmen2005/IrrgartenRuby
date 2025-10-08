#encoding:utf-8

require_relative 'weapon'
require_relative 'shield'
require_relative 'directions'
require_relative 'orientation'
require_relative 'game_character'
require_relative 'game_state'
require_relative 'dice'

module Irrgarten

	class Irrgarten
		
		def self.prueba_weapon(power, uses)
			
			w = Weapon.new(power, uses)
			puts w.to_s
			4.times do
				puts "Potencia de disparo #{w.attack}" 
				puts w.to_s
				puts "¿Descartamos el arma? #{w.discard}"
			end
	
		end
		
		def self.prueba_shield(protection, uses)
			
			s = Shield.new(protection, uses)
			puts s.to_s
			4.times do
				puts "Usamos escudo con protección #{s.protect}" 
				puts s.to_s
				puts "¿Descartamos el escudo? #{s.discard}"
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
		
		def self.prueba_dice(max, nplayers, competence)
			puts "Posición aleatoria: #{Dice.random_pos(max)}"
			puts "Empieza el jugador: #{Dice.who_starts(nplayers)}"
			puts "Nivel inteligencia: #{Dice.random_intelligence}"
			puts "Nivel de fuerza: #{Dice.random_strength}"
			puts "¿El jugador resucita? #{Dice.resurrect_player}"
			puts "Armas ganadas: #{Dice.weapons_reward}"
			puts "Escudos ganados: #{Dice.shields_reward}"
			puts "Salud ganada: #{Dice.health_reward}"
			puts "Poder del arma: #{Dice.weapons_power}"
			puts "Poder del escudo: #{Dice.shield_power}"
			puts "Usos restantes: #{Dice.uses_left}"
			puts "Intensidad: #{Dice.intensity(competence)}"
		end
	end
	
	puts "Comenzando la prueba de la Práctica 1 de PDOO"

	# PRUEBA DE WEAPON
	puts "Creando tres armas..."
	puts "Arma 1:"
	Irrgarten.prueba_weapon(10.0, 5)
	puts "Arma 2:"
	Irrgarten.prueba_weapon(7.5, 7)
	puts "Arma 3:"
	Irrgarten.prueba_weapon(5.75, 3)
	puts "------------"

	# PRUEBA DE SHIELD
	puts "Creando tres escudos..."
	puts "Escudo 1:"
	Irrgarten.prueba_shield(10.0, 5)
	puts "Escudo 2:"
	Irrgarten.prueba_shield(7.5, 7)
	puts "Escudo 3:"
	Irrgarten.prueba_shield(5.75, 3)
	puts "------------"

	# PRUEBA DE GAMESTATE
	puts "Visualizando el estado del juego..."
	Irrgarten.prueba_game_state
	puts "------------"

	# PRUEBA DE DICE
	puts "Probando el dado..."
	2.times do |i|
	  puts "---Prueba Dado #{i}"
	Irrgarten.prueba_dice(10, 5, 5)
	end
	puts "------------"
	
end

