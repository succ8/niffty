#!/bin/ruby

def hostname
  check_root
  print("Enter the new hostname: ")
  hostname_in = gets()
  hostname_file = File.open("/etc/hostname", "w")
  hostname_file.write "#{hostname_in}"
  hostname_file.close()

  hosts_file = File.open("/etc/hosts")
  hosts_lines = hosts_file.readlines.map(&:chomp)

  new_hosts = []
  hosts_lines.each_with_index do |element, index|
    ##TODO fix newline
    if element.include?("127.0.0.1")
      printf("127.0.0.1 #{hostname_in} localhost.localdomain\n")
    elsif element.start_with?("::1")
      printf("::1 #{hostname_in} localhost.localdomain ipv6-localhost ipv6-loopback\n")
    end
    ##TODO rewrite to file
    hosts_file.close()
end

  hosts_file.close()
end

def getAction
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
  action = getAction
  case action
  when 1
    hostname
  end
end
