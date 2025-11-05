#encoding:utf-8

module Irrgarten

	class GameState
		
		
		#constructor
		def initialize (labyrinth, players, monsters, currentPlayer, winner, log)
			@labyrinth = labyrinth #string
			@players = players #string
			@monsters = monsters #string
			@currentPlayer = currentPlayer #int
			@winner = winner #bool
			@log = log #string
		end
		
		#geters
		
		def labyrinth()
			@labyrinth
		end
		def players()
			@players
		end
		def monsters()
			@monsters
		end
		def current_player()
			@currentPlayer
		end
		def winner()
			@winner
		end
		def log()
			@log
		end
	end
end
