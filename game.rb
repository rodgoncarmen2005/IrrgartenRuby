#encoding:utf-8

require_relative 'player'
require_relative 'monster'
require_relative 'labyrinth'
require_relative 'dice'
require_relative 'game_state'
require_relative 'directions'
require_relative 'game_character'
require_relative 'orientation'

module Irrgarten
  class Game
    @@MAX_ROUNDS = 10
    @@ROWS = 10
    @@COLUMNS = 10
    @@NUM_MONSTERS = 6
    @@NUM_BLOCKS = 2

    attr_reader :current_player_index, :log, :current_player, :players, :monsters, :labyrinth

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

    def finished
      @labyrinth.have_a_winner
    end

    def next_step(preferred_direction)
      @log = ""

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
      next_player unless end_game
      end_game
    end

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

    def next_player
      if @current_player_index == @players.size - 1
        @current_player_index = 0
      else
        @current_player_index += 1
      end
      @current_player = @players[@current_player_index]
    end

    def actual_direction(preferred_direction)
      current_row = @current_player.row
      current_col = @current_player.col
      valid_moves = @labyrinth.valid_moves(current_row, current_col)
      @current_player.move(preferred_direction, valid_moves)
    end

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

    def manage_reward(winner)
      if winner == GameCharacter::PLAYER
        @current_player.received_reward
        log_player_won
      else
        log_monster_won
      end
    end

    def manage_resurrection
      resurrect = Dice.resurrect_player
      if resurrect
        @current_player.resurrect
        log_resurrected
      else
        log_player_skip_turn
      end
    end

    def log_player_won
      @log << "Winner: player #{@current_player_index}\n"
    end

    def log_monster_won
      @log << "Winner: monster\n"
    end

    def log_resurrected
      @log << "Resurrected: player #{@current_player_index}\n"
    end

    def log_player_skip_turn
      @log << "Player #{@current_player_index} skipped turn due to death\n"
    end

    def log_player_no_orders
      @log << "The instruction for player #{@current_player_index} could not be followed.\n"
    end

    def log_no_monster
      @log << "Player #{@current_player_index} moved to an empty square or it was not possible to move.\n"
    end

    def log_rounds(rounds, max)
      @log << "Round #{rounds} out of #{max}\n"
    end
  end
end

