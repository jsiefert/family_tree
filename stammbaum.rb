#!/usr/bin/ruby

class FamilyTree
  def initialize
    @root = {:id => 0, :title => '', :parent_id => nil}
  end
  
  def createTree(arr)
    map = {}
    arr.each do |e|
      map[e[:id]] = e
    end

    @tree = {}
    arr.each do |e|
      pid = e[:parent_id]
      if pid == nil || !map.has_key?(pid)
        (@tree[@root] ||= []) << e
      else
        (@tree[map[pid]] ||= []) << e
      end
    end
  end

  def print_tree(item=@root, level=0)
    items = @tree[item]
    unless items == nil
      indent = level > 0 ? sprintf("%#{level * 2}s", " ") : ""
      items.each do |e|
        puts "#{indent}-#{e[:title]}"
        print_tree(e, level + 1)
      end
    end
  end
end


#puts "Wer ist der erste?"
#first = gets.chomp

#puts "Wer ist seine Mutter?"
#mother = gets.chomp

#puts "Wer ist sein Vater?"
#father = gets.chomp

arr = Array.new
#arr << {:id=>1, :title=>"#{first}", :parent_id=>nil}
#arr << {:id=>2, :title=>"#{father}", :parent_id=>1}
#arr << {:id=>3, :title=>"#{mother}", :parent_id=>1}

create = FamilyTree.new

ending = 0
idCounter = 4
while ending != 1
  puts "Was wollen Sie tun?".center(40)
  puts "(1)display".ljust(10) + "=>".center(10) + "Den Stammbaum anzeigen".rjust(5)
  puts "(2)add".ljust(10) + "=>".center(10) + "Zu dem Stammbaum eine Person hinzufügen".rjust(5)
  puts "(3)edit".ljust(10) + "=>".center(10) + "Eine Person in dem Stammbaum bearbeiten".rjust(5)
  puts "(4)delete".ljust(10) + "=>".center(10) + "Eine Person aus dem Stammbaum löschen".rjust(5)
  puts "(5)close".ljust(10) + "=>".center(10) + "Beendet das Programm".rjust(5)
  choice = gets.chomp
  if choice == "add" || choice == "2"
    puts "Wie heißt die Person die Sie hinzufügen wollen?"
    personToCreate = gets.chomp
    puts "Zu wem wollen Sie #{personToCreate} hinzufügen?"
    personToAdd = gets.chomp
    if personToAdd == "nil"
      arr << {:id=>idCounter, :title=>"#{personToCreate}", :parent_id=>nil}
      idCounter += 1
      puts "Die Person #{personToCreate} wurde zu #{personToAdd} hinzugefügt!"
    else
      arr.each do |e|
        if e[:title] == personToAdd
          idOfPersonToAdd = e[:id]
          arr << {:id=>idCounter, :title=>"#{personToCreate}", :parent_id=>idOfPersonToAdd}
          idCounter += 1
          puts "Die Person #{personToCreate} wurde zu #{personToAdd} hinzugefügt!"
        end
      end
    end
  elsif choice == "display" || choice == "1"
    create.createTree(arr)
    create.print_tree
  elsif choice == "delete" || choice == "4"
    puts "Wenn wollen Sie löschen?"
    personToDelete = gets.chomp
    arr.delete_if {|e| e[:title] == "#{personToDelete}"}
  elsif choice == "edit" || choice == "3"
    puts "Wenn wollen Sie verändern?"
    personToChange = gets.chomp
    puts "Wie soll diese Person nun heißen?"
    givePersonNewName = gets.chomp
    arr.each do |e|
      if e[:title] == "#{personToChange}"
        e[:title] = "#{givePersonNewName}"
        puts "Der Name wurde von #{personToChange} in #{givePersonNewName} geändert!"
      end
    end
  elsif choice == "array"
    puts arr
  elsif choice == "close" || choice == "5"
    ending = 1
  else
    puts "Überprüfen Sie ihre Eingabe!"
  end
end
