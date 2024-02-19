#!/bin/ruby

def choose_action
  actions = ['Manage Packages', 'Configure Network']

  actions.each.with_index(1) do |action, index|
    puts "#{index}. #{action}"
  end

  input = 0
  while (not input.between?(1,actions.length()))
    print("Select an action: ")
    input = gets.to_i
  end
  return input
end

todo = choose_action

