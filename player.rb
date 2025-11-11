#encoding:utf-8

require_relative 'dice'
require_relative 'weapon'
require_relative 'shield'

module Irrgarten
  class Player
    
    @@MAX_WEAPONS = 2 #(max armas por jugador)
    @@MAX_SHIELDS = 3 #(max escudos por jugador)
    @@INITIAL_HEALTH = 10 #(salud inicial del jugador)
    @@HITS2LOSE = 3 #(num de golpes que puede recibir antes de morir)


	#/**
     #* Constructor de la clase Player. Se inicializa con una posicion (-1,-1) en el tablero.
     #* Actualmente no tiene armas ni escudos.
     #* @param number numero identificador del jugador
     #* @param intelligence inteligencia
     #* @param strength fuerza
     #*/	
  def initialize(number, intelligence, strength)
    @number = number.to_s
    @name = "Player #{@number}"
    @intelligence = intelligence
    @strength = strength
    @health = @@INITIAL_HEALTH

    @weapons = Array.new
    @shields = Array.new

    @consecutive_hits = 0; 
    @row = -1
    @col = -1
  end

    #/**
     #* Tareas asociadas a la resurreccion: reestablece la salud, el numero de golpes 
     #* consecutivos y elimina las armas y escudos.
     #*/
  def resurrect
    @weapons.clear
    @shields.clear
    @health = @@INITIAL_HEALTH
    reset_hits
  end
    
    #/**
     #* Getter de la fila en la que se encuentra posicionado el jugador.
     #* @return fila de la posición del jugador.
     #*/
  def row
    @row
  end
  
     #/**
     #* Getter de la columna en la que se encuentra posicionado el jugador.
     #* @return columna de la posicion del jugador.
     #*/
  def col
    @col
  end
    
     #/**
     #* Getter del numero identificador del jugador.
     #* @return numero de jugador.
     #*/  
  def number
    @number
  end

    #/**
     #* Setter de la posición del jugador en el laberinto.
     #* @param row fila dentro de la posicion.
     #* @param col columna dentro de la posicion.
     #*/
  def set_pos(row, col)
    @row = row
    @col = col
  end

     #/**
     #* Indica si el jugador esta muerto.
     #* @return true si el jugador esta muerto.
     #*/
  def dead
    @health <= 0
  end

     #/**
     #* Comprueba si la direccion a la que se quiere mover al jugador es valida o no. 
     #* Si es valida, la devuelve. Si no es valida, devuelve la primera direccion de
     #* validMoves. 
     #* @param direction direccion a la que se quiere mover el jugador.
     #* @param validMoves conjunto de movimientos validos
     #* @return la direccion a la que se movera el jugador
     #*/
  def move (direction, valid_moves)
    size = valid_moves.size
    contained = valid_moves.include?(direction)

    if size > 0 && !contained
      first_element = valid_moves[0]
      return first_element
    else
      return direction
    end
  end

    # /**
    # * Ataque del jugador: fuerza + suma de la potencia de las armas.
    # * @return valor correspondiente al ataque.
    # */
  def attack
    @strength + sum_weapons
  end

     #/**
     #* Defensa del jugador. El metodo manageHit lo gestiona.
     #* @param receivedAttack ataque recibido del monstruo.
     #* @return true si se defiende del ataque.
     #*/
  def defend(receive_attack)
    manage_hits(receive_attack)
  end

     #/**
     #* Gestiona la recompensa: crea y guarda armas escudos determinadas por el dado 
     #* (weaponsReward() y shieldsReward()) y aumenta la salud segun los resultados del
     #* dado (healthReward()). 
     #*/
  def receive_reward
    w_reward = Dice.weapons_reward
    s_reward = Dice.shields_reward

    w_reward.times do
      w_new = new_weapon
      receive_weapon(w_new)
    end

    s_reward.times do
      s_new = new_shield
      receive_shield(s_new)
    end

    extra_health = Dice.health_reward
    @health += extra_health
  end

     #/**
     #* Representacion del estado completo del jugador en una cadena.
     #* @return cadena con el estado del jugador.
     #*/
  def to_s
    s = "#{@name} [I:#{@intelligence}, S:#{@strength}, H:#{@health}, Pos:(#{@row},#{@col}), Hits:#{@consecutive_hits}]\n"
    
    #Weapons
    s += "\tWeapons: ["
    s += @weapons.map(&:to_s).join(' ') 
    s += "]\n"

    #Shields
    s += "\tShields: ["
    s += @shields.map(&:to_s).join(' ') 
    s += "]"
    
    s
  end


  private
    
     #/**
     #* Actualiza las armas de un jugador descartando las necesarias y añadiendo w si cabe.
     #* @param w el arma que se aniade.
     #*/
  def receive_weapon(w)
    (@weapons.size - 1).downto(0) do |i|
      wi = @weapons[i]
      discard = wi.discard
      if discard
      @weapons.delete(wi)
      end
	  end
	
    if @weapons.size < @@MAX_WEAPONS
      @weapons << w
    end
  end

     #/**
     #* Actualiza los escudos de un jugador descartando los necesarias y añadiendo s si cabe.
     #* @param s el escudo que se quiere aniadir. 
     #*/
  def receive_shield(s)
    (@shields.size - 1).downto(0) do |i|
      si = @shields[i]
      discard = si.discard

      if discard
      @shields.delete(si)
      end
    end

    if @shields.size < @@MAX_SHIELDS
      @shields << s
    end
  end
      
    # /**
    # * Crea un arma con los parametros que se decidan con el dado.
    # * @return una nueva arma.
    # */
  def new_weapon
    w = Weapon.new(Dice.weapon_power, Dice.uses_left)
  end
    
     #/**
     #* Crea un escudo con los parametros que se decidan con el dado.
     #* @return un nuevo escudo.
     #*/
  def new_shield
    s = Shield.new(Dice.shield_power, Dice.uses_left)
  end
    
     #/**
     #* Attack de todas las armas del jugador. 
     #* @return suma del resultado del metodo attack de todas las armas
     #*/
  def sum_weapons
    sum = 0
    @weapons.each do |w|
      sum += w.attack
    end
    sum
  end
    
     #/**
     #* Protect de todos los escudos.
     #* @return suma del resultado de llamar al método protect de todos sus escudos.
     #*/
  def sum_shields
    sum = 0
    @shields.each do |s|
      sum += s.protect
    end
    sum
  end
    
   #/**
   #* Defensa total del jugador como su inteligencia + proteccion de sus escudos.
   #* @return suma de inteligencia + proteccion de sus escudos. 
   #*/
  def defensive_energy
    @intelligence + sum_shields
  end
    
     #/**
     #* Gestiona los ataques recibidos.
     #* @param recivedAttack la instensidad del ataque recibido.
     #* @return true si el jugador ha muerto o llega al max de ataques consecutivos HIT2LOSE.
     #*/
  def manage_hits(received_attack)
    defense = self.defensive_energy
    lose = false;

    if defense < received_attack
      self.got_wounded
      self.inc_consecutive_hits
    else
      self.reset_hits
    end

    if (@consecutive_hits >= @@HITS2LOSE) || self.dead
      self.reset_hits
      lose = true
    end
    lose
  end
    
     #/**
     #* Fija el valor de impactos consecutivos a 0.
     #*/
  def reset_hits
    @consecutive_hits = 0
  end
    
     #/**
     #* Decrementa la salud en una unidad por herida.
     #*/
  def got_wounded
    @health -= 1
  end
    
     #/**
     #* Incrementa en una unidad el contador de impactos consecutivos.
     #*/
  def inc_consecutive_hits
    @consecutive_hits += 1
  end
end
end
