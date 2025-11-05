#encoding:utf-8

require_relative 'dice'
require_relative 'weapon'
require_relative 'shield'

module Irrgarten
  class Player
    
    @@MAX_WEAPONS = 2
    @@MAX_SHIELDS = 3
    @@INITIAL_HEALTH = 10
    @@HITS2LOSE = 3



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

  def resurrect
    if Dice.resurrect_player
      @weapons.clear
      @shields.clear
      @health = @@INITIAL_HEALTH
      reset_hits
    end
  end

  def row
    @row
  end

  def col
    @col
  end
  
  def number
    @number
  end

  def set_pos(row, col)
    @row = row
    @col = col
  end

  def dead
    @health <= 0
  end

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

  def attack
    @strength + sum_weapons
  end

  def defend(received_attack)
    manage_hits(received_attack)
  end

  def received_reward
    w_reward = Dice.weapons_reward
    s_reward = Dice.shields_reward

    w_reward.times do
      w_new = new_weapon
      received_weapon(w_new)
    end

    s_reward.times do
      s_new = new_shield
      received_shield(s_new)
    end

    extra_health = Dice.health_reward
    @health += extra_health
  end

  def to_s
    "Player #{@number} - Health: #{@health}, Weapons: #{sum_weapons}, Shields: #{sum_shields}, Pos: (#{@row}, #{@col})"
  end


  private

  def received_weapon(w)
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

  def received_shield(s)
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

  def new_weapon
    w = Weapon.new(Dice.weapon_power, Dice.uses_left)
  end

  def new_shield
    s = Shield.new(Dice.shield_power, Dice.uses_left)
  end

  def sum_weapons
    sum = 0
    @weapons.each do |w|
      sum += w.attack
    end
    sum
  end

  def sum_shields
    sum = 0
    @shields.each do |s|
      sum += s.protect
    end
    sum
  end

  def defensive_energy
    @intelligence + sum_shields
  end

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

  def reset_hits
    @consecutive_hits = 0
  end

  def got_wounded
    @health -= 1
  end

  def inc_consecutive_hits
    @consecutive_hits += 1
  end
end
end
