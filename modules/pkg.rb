#!/bin/ruby

module Pacman
    def Pacman.install(package)
        puts("\nInstalling package: #{package}")
        system("pacman -S #{package}")
    end
    def Pacman.update()
        puts("\nUpdating System")
        system("pacman -Syu")
    end
end

module Zypper
    def Zypper.install(package)
        puts("\nInstalling package: #{package}")
        system("zypper install #{package}")
    end
    def Zypper.update()
        puts("\nSyncing Repositories")
        system("zypper ref")
        puts("Updating System")
        system("zypper update")
    end
end

def getOS
    os_rel = File.open("/etc/os-release")
    os = "#{(os_rel.readline).match(/".*"/)}"[1..-2]
    os_rel.close()

    case os
        when "Arch Linux"
            return Pacman
        when "openSUSE Tumbleweed"
            return Zypper
        else
            puts("Error: OS unrecognized")
    end
end

def getInput
  actions = ['Install a Package', 'Remove a package', 'Update the system']

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

module Niffty_pkg
    pkg_mgr = getOS
    action = (getInput)
    case action
        when 1
            print("\nWhich package would you like to install? ")
            pkg_name = gets()
            pkg_mgr.install(pkg_name)
        when 2
            print("\nWhich package would you like to remove? ")
            pkg_name = gets()
        when 3
            pkg_mgr.update
    end
end
