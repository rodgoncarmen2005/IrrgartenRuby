#encoding:utf-8

require_relative 'player'
require_relative 'monster'
require_relative 'labyrinth'
require_relative 'dice'
require_relative 'game_state'
require_relative 'directions'
require_relative 'game_character'
require_relative 'orientation'
require_relative 'fuzzy_player'

module Irrgarten
  class Game
    @@MAX_ROUNDS = 10 #(Máximo de rondas en el juego)
    @@ROWS = 10 #(Filas del laberinto)
    @@COLUMNS = 10 #(Columnas del laberinto)
    @@NUM_MONSTERS = 4 #(Numero de monstruos del juego)
    @@NUM_BLOCKS = 2 #(Numero de obstaculos del juego)

    attr_reader :current_player_index, :log, :current_player, :players, :monsters, :labyrinth
	
	 #/**
     #* Constructor de la clase Player. Se crean los jugadores y se reparten, se crea y configura
     #* el laberinto y se decide quien empieza. 
     #* @param nplayers numero de jugadores de la partida.
     #*/
    def initialize(n_players)
      @players = []
      @monsters = []

      n_players.times do |i|
        p = Player.new(i, Dice.random_intelligence, Dice.random_strength)
        @players << p
      end

      @current_player_index = Dice.who_starts(n_players)
      @current_player = @players[@current_player_index]

      @labyrinth = Labyrinth.new(@@ROWS, @@COLUMNS, Dice.random_pos(@@ROWS), Dice.random_pos(@@COLUMNS))
      configure_labyrinth
      @labyrinth.spread_players(@players)
      @log = "Empieza el juego \n"
    end
	
	 #/**
     #* Indica si hay un ganador mediante el metodo de la clase Labyrinth.
     #* @return true si hay un ganador y se acaba el juego.
     #*/
    def finished
      @labyrinth.have_a_winner
    end

	 #/**
     #* Gestiona los turnos de la partida: comprueba si el jugador esta muerto, 
     #* mueve el jugador en el laberinto si es posible, comprueba si hay un combate,
     #* pregunta si se ha llegado al final de la partida y pasa de turno. 
     #* 
     #* @param peferredDirection direccion a la que se quiere mover el jugador.
     #* @return true si finaliza el juego.
     #*/
    def next_step(preferred_direction)
      @log = "" #reseteamos log

      dead = @current_player.dead

      if !dead
        direction = actual_direction(preferred_direction)

        if direction != preferred_direction
          log_player_no_orders
        end

        monster = @labyrinth.put_player(direction, @current_player)

        if monster == nil
          self.log_no_monster
        else
          winner = self.combat(monster)
          self.manage_reward(winner)
        end
      else
        self.manage_resurrection
      end

      end_game = self.finished
      if(!end_game)
      	self.next_player
      end
      end_game
    end

	 #/**
     #* Genera una instancia de GameState integrando toda la información del estado del juego.
     #* @return objeto GameState con el estado actual del juego.
     #*/
    def game_state
      players_info = ""
      monsters_info = ""

      @players.each do |p|
        players_info += "+ #{p}\n"
      end

      @monsters.each do |m|
        monsters_info += "+ #{m}\n"
      end

      GameState.new(@labyrinth.to_s, players_info, monsters_info, @current_player_index, self.finished, @log)
    end

    private

	 #/**
     #* Configura el laberinto añadiendo bloques de obstáculos y monstruos.
     #* Los monstruos se guardan en el contenedor del juego.
     #*/
    def configure_labyrinth
      @@NUM_MONSTERS.times do |i|
        monster = Monster.new("Monster#{i}", Dice.random_intelligence, Dice.random_strength)
        @monsters << monster
        @labyrinth.add_monster(Dice.random_pos(@@ROWS), Dice.random_pos(@@COLUMNS), monster)
      end

      # Bloques prefijados
      @labyrinth.add_block(Orientation::HORIZONTAL, 5, 4, 2)
      @labyrinth.add_block(Orientation::VERTICAL, 9, 8, 1)
    end
	
	 #/**
     #* Actualiza los valores de currentPlayerIndex y currentPlayer con el turno pasando 
     #* al siguiente jugador.
     #*/
    def next_player
      if @current_player_index == @players.size - 1
        @current_player_index = 0
      else
        @current_player_index += 1
      end
      @current_player = @players[@current_player_index]
    end
	
	 #/**
     #* Mueve al jugador a preferredDirection si es posible. Se movera a otra casilla
     #* si preferredDirection no es valida.
     #* @param preferredDirection direccion a la que se quiere mover el jugador.
     #* @return direccion a la que se mueve el jugador
     #*/
    def actual_direction(preferred_direction)
      current_row = @current_player.row
      current_col = @current_player.col
      valid_moves = @labyrinth.valid_moves(current_row, current_col)
      @current_player.move(preferred_direction, valid_moves)
    end
	
	 #/**
     #* Gestiona los combates. Se producen ataques y defensas por rondas con un max de 
     #* MAX_ROUNDS. 
     #* @param monster el monstruo que interviene en el combate.
     #* @return ganador del combate.
     #*/
    def combat(monster)
      rounds = 0
      winner = GameCharacter::PLAYER

      player_attack = @current_player.attack
      lose = monster.defend(player_attack)

      while !lose && rounds < @@MAX_ROUNDS
        winner = GameCharacter::MONSTER
        rounds += 1

        monster_attack = monster.attack
        lose = @current_player.defend(monster_attack)

        unless lose
          player_attack = @current_player.attack
          winner = GameCharacter::PLAYER
          lose = monster.defend(player_attack)
        end
      end

      self.log_rounds(rounds, @@MAX_ROUNDS)
      winner
    end
	
	 #/**
     #* Gestiona las recompensas de ganar un combate. Actualiza el log con el 
     #* ganador del combate (monstruo o jugador).
     #* @param winner ganador del combate (monstruo o jugador).
     #*/
    def manage_reward(winner)
      if winner == GameCharacter::PLAYER
        @current_player.receive_reward
        log_player_won
      else
        log_monster_won
      end
    end
	
	 #/**
     #* Maneja la resurrecion del jugador. Se decide con los resultados del dado.
     #* Se aniade a log si el jugador resucita o no. Si no resucita, logPlayerSkipTurn().
     #*/
    def manage_resurrection
      resurrect = Dice.resurrect_player
      if resurrect
        @current_player.resurrect
        log_resurrected
        # Lo convertimos en Fuzzy
        fuzzy = FuzzyPlayer.new(@current_player)

        # Modificamos el array de jugadores
        @players[@current_player_index] = fuzzy

        # Modificamos la tabla de jugadores en el laberinto
        @labyrinth.to_fuzzy(fuzzy)
      else
        log_player_skip_turn
      end
    end

	 #/**
     #* Se añade a log el jugador ganador del combate.
     #*/
    def log_player_won
      @log << "Winner: player #{@current_player_index}\n"
    end
	
	 #/**
     #* Se añade a log el monstruo ganador del combate.
     #*/
    def log_monster_won
      @log << "Winner: monster\n"
    end

	 #/**
     #* Se añade a log que el jugador actual ha resucitado.
     #*/
    def log_resurrected
      @log << "Resurrected: player #{@current_player_index}\n"
    end

	 #/**
     #* Se añade a log que el jugador a perdido su turno debido a que estaba muerto.
     #*/
    def log_player_skip_turn
      @log << "Player #{@current_player_index} skipped turn due to death\n"
    end
	
	 #/**
     #* Se añade a log que el jugador ha intentado un accion no permitida.
     #*/
    def log_player_no_orders
      @log << "The instruction for player #{@current_player_index} could not be followed.\n"
    end
	
	 #/**
     #* Se añade a log que el jugador se ha movido a una casilla vacia o no ha sido posible moverse.
     #*/
    def log_no_monster
      @log << "Player #{@current_player_index} moved to an empty square or it was not possible to move.\n"
    end
	
	 #/**
     #* Se añade a log que se han producido rounds/max rondas de combate.
     #* @param rounds numero de rondas que se han producido.
     #* @param max max numero de rondas permitidas en un combate.
     #*/
    def log_rounds(rounds, max)
      @log << "Round #{rounds} out of #{max}\n"
    end
  end
end

