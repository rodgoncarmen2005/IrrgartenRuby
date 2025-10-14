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
    
    #dead?
    def dead
      @health <= 0
    end

    #attack
    def attack
      Dice.intensity(@strength)
    end

    #defend
    def defend
      
    end

    #pos
    def pos (row, col)
      @row = row
      @col = col
    end
    #got_wounded
    def got_wounded
      @health -= 1
    end

    
    #toString
    def to_s ()
      "M[#{@name}, #{@strength}, #{@intelligence}, #{@health}, #{@row}, #{@col}]"
    end
  end
end