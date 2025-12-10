#encoding:utf-8

require_relative 'dice'
require_relative 'labyrinth_character'

module Irrgarten

  class Monster < LabyrinthCharacter
    
    @@INITAL_HEALTH = 5

    #constructor
    def initialize (name, intelligence, strength)
      super(name, intelligence, strength, @@INITAL_HEALTH)
    end

    #attack --> intensidad del ataque
    def attack
      Dice.intensity(@strength)
    end

    #defend
    def defend(received_attack)
      is_dead = self.dead
      if !is_dead
        defend_intensity = Dice.intensity(@intelligence)
        if defend_intensity < received_attack
        got_wounded
        end
      end
      is_dead = self.dead
      return is_dead
    end

  end
end
