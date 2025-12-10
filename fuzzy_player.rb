#encoding:utf-8

module Irrgarten
	class Fuzzyplayer < Player
	
	# Constructor de la clase FuzzyPlayer. Llama al mismo método de su superclase.
 	# @param other instancia FuzzyPlayer que se va a copiar.
  	def initialize(other)
    	super
  	end

	# Devuelve una dirección basada en: la dirección que devuelve move de Player
	# pasada al método Dice.next_step.
	# @param direction dirección de movimiento preferida
	# @param valid_moves array de las direcciones válidas
	# @return dirección de movimiento elegida
	def move(direction, valid_moves)
		dir = super(direction, valid_moves)
		dir = Dice.next_step(dir, valid_moves, get_intelligence)
		dir
	end

	# Ataque del jugador fuzzy: intensidad según Dice + suma de la potencia de las armas.
	# @return valor correspondiente al ataque.
	def attack
		sum_weapons + Dice.intensity(get_strength)
	end

	# Defensa total del jugador como su intensidad según Dice + protección de sus escudos.
	# @return suma de inteligencia + protección de sus escudos.
	protected def defensive_energy
		sum_shields + Dice.intensity(get_intelligence)
	end

	# Representación del estado completo del FuzzyPlayer en una cadena.
	# @return cadena con el estado del FuzzyPlayer.
	def to_s
		"Fuzzy " + super
	end
	
	end
end
	
	
