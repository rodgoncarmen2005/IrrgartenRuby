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

    #constructor inicializa el laberinto a vacío y coloca la salida
    def initialize (n_rows, n_cols, exit_row, exit_col)
      @rows = nrows.to_i
      @cols = ncols.to_i
      @exit_row = exit_row.to_i
      @exit_col = exit_col.to_i
      
      @monster = Array.new(n_rows) { Array.new(n_cols, @@EMPTY_CHAR) }
      @labyrinth = Array.new(n_rows) { Array.new(n_cols, nil) }
      @players = Array.new(n_rows) { Array.new(n_cols, nil) }

      labyrinth[exit_row][exit_col] = @@EXIT_CHAR

    end

    #Coloca los jugadores en posiciones aleatorias dentro del tablero
    def spread_players (Array players)
      player.each do |player|
        pos = self.random_empty_pos #int []
        self.put_player_2D(-1, -1, pos[ROW], pos[COL], player)
    end

    #Devuelve true si hay un ganador (un jugador en la salida)
    def have_a_winner
      @players[@exit_row][@exit_col] != nil
    end

    #Muestra el laberinto por pantalla
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

    # Añade un monstruo en la posición indicada
    def add_monster(row, col, monster)
      if pos_ok(row, col) && empty_pos(row, col)
        @labyrinth[row][col] = @@MONSTER_CHAR
        @monster[row][col] = monster
        monster.pos(row, col)
      end
    end

    # Mueve al jugador en la dirección indicada y devuelve el monstruo si lo hay
    def put_player(direction, player)
      old_row = player.row
      old_col = player.col
      new_pos = dir_2_pos(old_row, old_col, direction)
      monster = put_player_2D(old_row, old_col, new_pos[ROW], new_pos[COL], player)
      monster
    end

    # Añade un muro en la orientación, posición y longitud indicadas
    def add_block(orientation, start_row, start_col, length)
      inc_col = 0
      inc_row = 0
      if orientation == 'VERTICAL'
        inc_row = 1
      if orientation == 'HORIZONTAL'
        inc_col = 1
      end
      row = start_row
      col = start_col
      while pos_ok(row, col) && empty_pos(row, col) && length > 0
        @labyrinth[row][col] = @@BLOCK_CHAR
        row += inc_row
        col += inc_col
        length -= 1
      end
    end

    # Devuelve las direcciones válidas desde la posición indicada
    def valid_moves(row, col)
      output = Array.new
      if can_step_on(row+1, col)
        output.push(Directions::DOWN)
      end
      if can_step_on(row-1, col)
        output.push(Directions::UP)
      end
      if can_step_on(row, col+1)
        output.push(DIRECTIONS::RIGHT)
      end
      if can_step_on(row, col-1)
        output.push(DIRECTIONS::LEFT)
      end
      output
    end

    private

    # Devuelve true si la posición está dentro del tablero y es válida
    def pos_ok(row, col)
      row >= 0 && row < @rows && col >= 0 && col < @cols
    end

    # Devuelve true si la posición está vacía
    def empty_pos(row, col)
      @labyrinth[row][col] == @@EMPTY_CHAR
    end

    # Devuelve true si la posición tiene un monstruo
    def monster_pos(row, col)
      @labyrinth[row][col] == @@MONSTER_CHAR
    end

    # Devuelve true si la posición es la salida
    def exit_pos(row, col)
      @labyrinth[row][col] == @@EXIT_CHAR
    end

    # Devuelve true si la posición tiene un combate
    def combat_pos(row, col)
      @labyrinth[row][col] == @@COMBAT_CHAR
    end

    # Devuelve true si puedes moverte a esa posición
    def can_step_on(row, col)
      pos_ok(row,col) && (empty_pos(row, col) || monster_pos(row, col) || combat_pos(row, col))
    end

    # Actualiza una posicón válida después de que un jugador se haya movido
    def update_old_pos(row, col)
      if(pos_ok(row, col))
        if(combat_pos(row, col))
          @labyrinth[row][col] = @@MONSTER_CHAR
        else
          @labyrinth[row][col] = @@EMPTY_CHAR
        end
      end
    end

    # Devuelve la nueva posición después de moverse en una dirección
    def dir_2_pos(row, col, direction)

      salida = [@@ROW, @@COL]

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
        salida[0] = row
        salida[1] = col

        salida

    end

    # Devuelve una posición aleatoria vacía dentro del tablero
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

    # Mueve al jugador a la posición indicada y devuelve el monstruo si lo hay
    def put_player_2D(old_row, old_col, row, col, player)
      monster = nil
      if self.can_step_on(row, col)
        if self.can_step_on(old_row, old_col)
          p = @players[old_row][old_col]
          if p == player
            self.update_old_pos(old_row, old_col)
            @players[old_row][old_col] = nil
          end
        end

        monster_pos = self.monster_pos(row, col)
        if monster_pos
          @labyrinth[row][col] = @@COMBAT_CHAR
          monster = @monster[row][col]
        else
          number = player.number
          @labyrinth[row][col] = number.to_s
        end
        @players[row][col] = player
        player.set_pos(row, col)

        monster

      end
    end 

end
