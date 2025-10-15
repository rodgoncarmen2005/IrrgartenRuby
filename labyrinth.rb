#encoding:utf-8

module Irrgarten

  class Labyrinth 
    @@BLOCK_CHAR = 'X'
    @@EMPTY_CHAR = '-'
    @@MONSTER_CHAR = 'M'
    @@COMBAT_CHAR = 'C'
    @@EXIT_CHAR = 'E'
    @@ROW = 0
    @@COL = 1

    #constructor
    def initialize (n_rows, n_cols, exit_row, exit_col)
      @rows = nrows.to_i
      @cols = ncols.to_i
      @exit_row = exit_row.to_i
      @exit_col = exit_col.to_i
      
      @monster = Array.new(n_rows) { Array.new(n_cols, false) }
      @labyrinth = Array.new(n_rows) { Array.new(n_cols, false) }
      @players = Array.new(n_rows) { Array.new(n_cols, false) }

      labyrinth[exit_row][exit_col] = @@EXIT_CHAR

    end

    def spread_platers (Array players)

    end

    def have_a_winner
      @players[@exit_row][@exit_col] != nil
    end

    def to_s
      str = ""
      for r in 0...@rows
        for c in 0...@cols
          str += @labyrinth[r][c].to_s
        end
        str += "\n"
      end
      str
    end

    def add_monster(row, col, monster)
      if pos_ok(row, col) && empty_pos(row, col)
        @labyrinth[row][col] = @@MONSTER_CHAR
        @monster[row][col] = monster
        monster.pos(row, col)
      end
    end

    def put_player(direction, player)
    
    end

    def add_block(orientation, start_row, start_col, length)
 
    end

    def valid_moves(row, col)
    
    end

    private

    def pos_ok(row, col)
      row >= 0 && row < @rows && col >= 0 && col < @cols
    end

    def empty_pos(row, col)
      @labyrinth[row][col] == @@EMPTY_CHAR
    end

    def monster_pos(row, col)
      @labyrinth[row][col] == @@MONSTER_CHAR
    end

    def exit_pos(row, col)
      @labyrinth[row][col] == @@EXIT_CHAR
    end

    def combat_pos(row, col)
      @labyrinth[row][col] == @@COMBAT_CHAR
    end

    def can_step_on(row, col)
      pos_ok(row,col) && (empty_pos(row, col) || monster_pos(row, col) || combat_pos(row, col))
    end

    def update_old_pos(row, col)
      if(pos_ok(row, col))
        if(combat_pos(row, col))
          @labyrinth[row][col] = @@MONSTER_CHAR
        else
          @labyrinth[row][col] = @@EMPTY_CHAR
        end
      end
    end

    def dir_2_pos(row, col, direction)

      case direction
      when 'LEFT'
        col -= 1
      when 'RIGHT'
        col += 1
      when 'UP'
        row -= 1
      when 'DOWN'
        row += 1
      end
      [row, col]
    end

    def random_empty_pos
      row = -1
      col = -1
      row = Dice.random_pos(@n_rows)
      col = Dice.random_pos(@n_cols)
      while(!empty_pos(row,col))
        row = Dice.random_pos(@n_rows)
        col = Dice.random_pos(@n_cols)
      end
      [row, col]
    end

    def put_player_2D(old_row, old_col, row, col, player)

    end

  end 

end
