#!/bin/ruby

##  TODO
# - Network Managing
# - Desktop Setup
# - KVM
# - Setup VNC/SSH
# - Other Inputs
# - Printer

def choose_action
  actions = ['Manage Packages', 'Configure Network']

  actions.each.with_index(1) do |action, index|
    puts "#{index}. #{action}"
  end

  input = 0
  while (not input.between?(1,actions.length()))
    print("\nSelect an action: ")
    input = gets.to_i
  end
  return input
end

action = choose_action
case action
when 1
  require_relative 'modules/pkg'
  include Niffty_pkg
when 2
  require_relative 'modules/net'
  include Niffty_net
end
