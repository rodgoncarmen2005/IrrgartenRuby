#encoding:utf-8

module Irrgarten

require_relative 'game'
require_relative 'UI/textUI'
require_relative 'Controller/controller'

# MAIN
if __FILE__ == $0
  game = Game.new(2)
  view = UI::TextUI.new
  controller = Control::Controller.new(game, view)
  controller.play
end

end

