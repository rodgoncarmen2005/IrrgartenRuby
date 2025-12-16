#encoding:utf-8

module Irrgarten
	class LabyrinthCharacter
	
	protected
    attr_reader :name
    attr_reader :intelligence
    attr_reader :strength
    attr_accessor :health

    public
    attr_reader :row
    attr_reader :col
	
     # Constructor para el objeto LabyrinthCharacter. Se inicializa con una posicion (-1,-1) en el tablero.
     # @param name nombre del personaje
     # @param intelligence inteligencia del personaje
     # @param strength fuerza del personaje
     # @param health salud del personaje
     #
	def initialize (name, intelligence, strength, health)
		@name = name
		@intelligence = intelligence
		@strength = strength
		@health = health
		
		@row = -1; 
		@col = -1; 
	end
	
     # Indica si el jugador esta muerto, es decir, si no posee nada de salud.
     # @return true si el jugador esta muerto.
     #
	def dead()
		@health <= 0
	end
	
	 #
     # Constructor de copia para el objeto LabyrinthCharacter.
     # @param other objeto LabyrinthCharacter a copiar.
     #
	def copy (other)
		@name = other.name
		@intelligence = other.intelligence
		@strength = other.strength
		@health = other.health
		
		pos(other.row, other.col)
	end
	
	 #/**
     #* Getter de la fila en la que se encuentra posicionado el personaje.
     #* @return fila de la posición del personaje.
     #*/
	def row
	    @row
	end
  
     #/**
     #* Getter de la columna en la que se encuentra posicionado el personaje.
     #* @return columna de la posicion del personaje.
     #*/
	def col
	    @col
	end
	
	
	protected 
	
	# Getter de la inteligencia del personaje.
	# @return inteligencia del personaje.
	def intelligence
	  @intelligence
	end

	# Getter de la fuerza del personaje.
	# @return fuerza del personaje.
	def strength
	  @strength
	end

	# Getter de la salud del personaje.
	# @return salud del personaje.
	def health
	  @health
	end

	public
	# Setter de la salud del personaje.
	# @param health cantidad de salud a asignar
	def set_health(health)
	  @health = health
	end
	
		
	public 
	
	# Setter de la posición del jugador en el laberinto.
	# @param row fila dentro de la posicion.
	# @param col columna dentro de la posicion.
	def pos(row, col)
	  @row = row
	  @col = col
	end

	# Representación del estado completo del personaje en una cadena.
	# @return cadena con el estado del personaje.
	def to_s
	  "#{@name}[I:#{@intelligence}, S:#{@strength}, H:#{@health}, Pos:#{@row},#{@col}]\n"
	end

	# Decrementa la salud en una unidad por herida.
	def got_wounded
	  @health -= 1
	end

	# Método abstracto attack()
	def attack
	  raise NotImplementedError
	end

	# Método abstracto defend(attack)
	def defend(attack)
	  raise NotImplementedError
	end
end
end
