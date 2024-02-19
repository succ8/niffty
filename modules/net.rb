#!/bin/ruby
def hostname
  check_root
  print("Enter the new hostname: ")
  hostname_in = gets()
  hostname_file = File.open("/etc/hostname", "w")
  hostname_file.write "#{hostname_in}"
  hostname_file.close()
end

def getInput
  actions = ['Configure hostname']

  puts("")
  actions.each.with_index(1) do |action,index|
    puts "#{index}. #{action}"
  end

  input = 0
  while (not input.between?(1,actions.length()))
    print("\nSelect an action: ")
    input = gets.to_i
  end
  return input
end

def check_root
  if Process.uid !=0
    puts("To use this function, run with sudo")
    exit 1
  end
end

module Niffty_net
  action = getInput
  case action
  when 1
    hostname
  end
end
