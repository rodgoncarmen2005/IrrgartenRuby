#encoding:utf-8

require_relative 'dice'

module Irrgarten

  class CombatElement

    # Constructor
    def initialize(effect, uses)
      @effect = effect.to_f
      @uses = uses.to_i
    end

    # produce_effect --> determina si quedan usos y devuelve el efecto del elemento de combate
    def produce_effect
      output = 0.0
      if (@uses > 0)
        @uses -= 1
        output = @effect
      end
      output
    end

    # discard_element --> devuelve si se desecha el elemento de combate apoyandose en Dice.discard_element
    def discard
      Dice.discard_element(@uses)
    end

    # toString --> muestra los atributos del elemento de combate
    def to_s
      "[Effect: #{@effect}, Uses: #{@uses}"
    end


    protected :produce_effect

    private_class_method :new #esto es para que no se pueda instanciar la clase (similar a abstract)

  end
end