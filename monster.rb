#encoding:utf-8

require_relative 'dice'

module Irrgarten

  class Monster
    
    @@INITAL_HEALTH = 5

    #constructor
    def initialize (name, intelligence, strength)
      @name = name #string
      @intelligence = intelligence #float
      @strength = strength #float
      @health = @@INITAL_HEALTH #int
      @row = -1 #int
      @col = -1 #int
    end
    

    #dead --> true si el monstruo está muerto
    def dead
      @health <= 0
    end

    #attack --> intensidad del ataque
    def attack
      Dice.intensity(@strength)
    end

    #defend
    def defend
      
    end

    #pos --> establece la posición del monstruo
    def pos (row, col)
      @row = row
      @col = col
    end

        
    #toString muestra los atributos del monstruo
    def to_s ()
      "M[#{@name}, #{@strength}, #{@intelligence}, #{@health}, #{@row}, #{@col}]"
    end

    private

    #got_wounded --> reduce la salud del monstruo en 1
    def got_wounded
      @health -= 1
    end

  end
end