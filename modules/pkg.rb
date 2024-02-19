#!/bin/ruby

##  TODO
# - Multiple packages
# - Apt support
# - Search for specific package

module Pacman
    def Pacman.install(package)
      puts("\nInstalling package: #{package}")
      system("pacman -S #{package}")
    end
    def Pacman.update()
      puts("\nUpdating System")
      system("pacman -Syu")
    end
    def Pacman.remove(package)
      puts("\nRemoving package: #{package}")
      system("pacman -Rns #{package}")
    end
    def Pacman.list()
      puts("\nInstalled packages:")
      system("pacman -Qe")
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
    def Zypper.remove(package)
      puts("\nRemoving package: #{package}")
      system("zypper remove --clean-deps #{package}")
    end
    def Zypper.list()
      puts("\nInstalled packages:")
      system("zypper se | grep ^i+ | cut -d '|' -f2")
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
  actions = ['Install a package', 'Remove a package', 'Update the system', 'List installed packages']

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
      if Process.uid != 0
        puts("To use this function, run with sudo")
      else
        print("\nWhich package would you like to install? ")
        pkg_name = gets()
        pkg_mgr.install(pkg_name)
      end
    when 2
      if Process.uid != 0
        puts("To use this function, run with sudo")
      else
        print("\nWhich package would you like to remove? ")
        pkg_name = gets()
        pkg_mgr.remove(pkg_name)
      end
    when 3
      if Process.uid != 0
        puts("To use this function, run with sudo")
      else
        pkg_mgr.update
      end
    when 4
      pkg_mgr.list
  end
end
