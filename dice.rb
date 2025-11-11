#encoding:utf-8

require_relative 'dice'

module Irrgarten

	class Dice
		
		@@MAX_USES = 5 #(número máximo de usos de armas y escudos)
		@@MAX_INTELLIGENCE = 10.0 #(valor máximo para la inteligencia de jugadores y monstruos)
		@@MAX_STRENGTH = 10.0 #(valor máximo para la fuerza de jugadores y monstruos)
		@@RESURRECT_PROB = 0.3 #(probabilidad de que un jugador sea resucitado en cada turno)
		@@WEAPONS_REWARD = 2 #(numero máximo de armas recibidas al ganar un combate)
		@@SHIELDS_REWARD = 3 #(numero máximo de escudos recibidos al ganar un combate)
		@@HEALTH_REWARD = 5 #(numero máximo de unidades de salud recibidas al ganar un combate)
		@@MAX_ATTACK = 3 #(máxima potencia de las armas)
		@@MAX_SHIELD = 2 #(máxima potencia de los escudos) 
		
		@@generator = Random.new #https://ruby-doc.org/core-2.4.7/Random.html
		
	  #/**
      #* Devuelve un número de fila o columna aleatoria entre 0 y max.
      #* @param max El numero de filas o columnas del tablero.
      #* @return número de fila o columna aleatoria entre [0, max).
      #*/   
		def self.random_pos(max)
			@@generator.rand(max)
		end
		
	#/**
     #* Devuelve el índice del jugador que comenzará la partida.
     #* 
     #* @param nplayers Número de jugadores en la partida
     #* @return indice aleatorio del jugador que comenzará la partida [0, nplayers).
     #*/
		def self.who_starts(nplayers)
			@@generator.rand(nplayers)
		end
		
	 #/**
     #* @return Valor aleatorio de inteligencia en el intervalo [0, MAX_INTELLIGENCE).
     #*/
		def self.random_intelligence
			@@generator.rand(@@MAX_INTELLIGENCE)
		end
		
	 #/**
     #* @return Valor aleatorio de fuerza en el intervalo [0, MAX_STRENGTH).
     #*/
		def self.random_strength
			@@generator.rand(@@MAX_STRENGTH)
		end
		
	 #/**
     #* Determina si un jugador muerto debe ser resucitado o no con una probabilidad RESURRECT_PROB.
     #* @return boolean indicando si el jugador debe ser resucitado.
     #*/
		def self.resurrect_player
			@@generator.rand <= @@RESURRECT_PROB
		end
		
	 #/**
     #* Indica la cantidad de armas que recibira el jugador por ganar el combate.
     #* @return numero aleatorio [0, WEAPONS_REWARD]
     #*/
		def self.weapons_reward
			@@generator.rand(@@WEAPONS_REWARD+1)
		end
		
	 #/**
     #* Indica la cantidad de escudos que recibira el jugador por ganar el combate.
     #* @return numero aleatorio [0, SHIELDS_REWARD]
     #*/
		def self.shields_reward
			@@generator.rand(@@SHIELDS_REWARD+1)
		end
		
	 #/**
     #* Indica la potencia que tendra un arma.
     #* @return valor aleatorio [0, MAX_ATTACK). 
     #*/
		def self.weapon_power
			@@generator.rand(@@MAX_ATTACK.to_f)
		end
		
	 #/**
     #* Indica la potencia que tendra un escudo.
     #* @return valor aleatorio [0, MAX_SHIELD). 
     #*/
		def self.shield_power
			@@generator.rand(@@MAX_SHIELD.to_f)
		end
		    
     #/**
     #* Indica la cantidad de unidades de salud que recibira el jugador por ganar el combate.
     #* @return numero aleatorio [0, HEALTH_REWARDú]
     #*/
		def self.health_reward
			@@generator.rand(@@HEALTH_REWARD+1)
		end
		    
     #/**
     #* Indica el numero de usos que se asignara a un arma o escudo.
     #* @return numero aleatorio [0, MAX_USES].
     #*/
		def self.uses_left
			@@generator.rand(@@MAX_USES+1)
		end
		
	 #/**
     #* Devuelve la cantidad de competencia aplicada. 
     #* @param competence la competencia aplicada
     #* @return valor aleatorio en [0, competence).
     #*/
		def self.intensity(competence)
			@@generator.rand(competence)
		end
		
	 #/**
     #* Indica si se descarta un arma o escudo con una probabilidad inversamente proporcional 
     #* a lo cercano que esté el parámetro del número máximo de usos que puede tener un arma o escudo. 
     #* Las armas o escudos con más usos posibles es menos probable que sean descartados.
     #* @param usesLeft el numero de usos del arma o escudo. 
     #* @return boolean que indica si se descartara el elemento o no. 
     #*/
		def self.discard_element(uses_left)
			@@generator.rand >= ((uses_left.to_f)/@@MAX_USES)
		end
	end
end
		
