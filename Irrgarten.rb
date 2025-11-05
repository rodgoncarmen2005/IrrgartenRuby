# encoding:utf-8

require_relative 'weapon'
require_relative 'shield'
require_relative 'directions'
require_relative 'orientation'
require_relative 'game_character'
require_relative 'game_state'
require_relative 'dice'
require_relative 'monster'
require_relative 'labyrinth'
require_relative 'player'

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
			
			gs = GameState.new(laberinto, jugadores, monstruos, numjugadores, ganador, historia)
			puts "Labyrinth: #{gs.labyrinth}"
			puts "Players: #{gs.players}"
			puts "Monsters: #{gs.monsters}"
			puts "Current Player: #{gs.current_player}"
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

		def self.prueba_monster(name, strength, intelligence)
			m = Monster.new(name, strength, intelligence)
			puts m.to_s
			puts "Ataque: #{m.attack}"
			puts "¿Está muerto? #{m.dead}"
			received_attack = 8
			puts "Defendiendo contra un ataque de intensidad #{received_attack}"
			is_dead = m.defend(received_attack)
			puts "Después de defender: #{m.to_s}"
			puts "¿Está muerto después del ataque? #{is_dead}"
			m.pos(2, 3)
			puts "Después de cambiar de posición: #{m.to_s}"
		end

		def self.prueba_laberinth
			l = Labyrinth.new(10, 10, 9, 9)
			puts "Laberinto inicial:"
			puts l.to_s

			puts "Añadiendo bloques..."
			l.add_block(Orientation::HORIZONTAL, 0, 5, 5)
			l.add_block(Orientation::VERTICAL, 2, 2, 6)
			puts l.to_s

			players = Array.new
			players << Player.new('1', 5.0, 7.0)
			players << Player.new('2', 6.0, 6.5)

			puts "Añadiendo jugadores..."
			l.spread_players(players)
			puts l.to_s

			puts "Añadiendo un monstruo..."
			m = Monster.new("Ogro", 5.0, 6.0)
			l.add_monster(5, 5, m)
			puts l.to_s

			puts "Moviendo al jugador 1 hacia abajo..."
			l.put_player(Directions::DOWN, players[0])
			puts l.to_s

			puts "Calculando movimientos válidos para el jugador 1..."
			player = players[0]
			row = player.row
			col = player.col
			array = l.valid_moves(row, col)

			puts "Movimientos válidos para el jugador 1 en la posición (#{row},#{col}): #{array}"

			l.put_player(Directions::RIGHT, player)
			puts l.to_s
		end

			

	end
	
	# Inicio de pruebas
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
		puts "---Prueba Dado #{i}---"
		Irrgarten.prueba_dice(10, 5, 5)
	end
	puts "------------"

	# PRUEBA DE MONSTER
	puts "Probando la creación de monstruos..."
	Irrgarten.prueba_monster("Ogro", 7.5, 3.5)
	Irrgarten.prueba_monster("Araña", 5.0, 8.0)
	puts "------------"

	# PRUEBA DE LABERINTO
	puts "Probando la creación del laberinto..."
	Irrgarten.prueba_laberinth
	puts "------------"

end
