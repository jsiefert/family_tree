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
    puts @tree
  end

  def print_tree(item=@root, level=0)
    items = @tree[item]
    unless items == nil
      indent = level > 0 ? sprintf("%#{level * 2}s", " ") : ""
      items.each do |e|
        puts "#{indent}-#{e[:title]}(#{e[:id]})"
        print_tree(e, level + 1)
      end
    end
  end
end

arr = Array.new
create = FamilyTree.new
ending = 0
idCounter = 1
output = "Alles wie immer!"

while ending != 1
  system("clear")
  create.createTree(arr)
  create.print_tree
  puts ""
  puts "Ausgabe: #{output}"
  puts ""
  puts "Was wollen Sie tun?".center(40)
  puts "(1)add".ljust(10) + "=>".center(10) + "Zu dem Stammbaum eine Person hinzufügen".rjust(5)
  puts "(2)delete".ljust(10) + "=>".center(10) + "Eine Person aus dem Stammbaum löschen".rjust(5)
  puts "(3)edit".ljust(10) + "=>".center(10) + "Eine Person in dem Stammbaum bearbeiten".rjust(5)
  puts "(4)export".ljust(10) + "=>".center(10) + "Benutzerdaten werden exportiert".rjust(5)
  puts "(5)import".ljust(10) + "=>".center(10) + "Benutzerdaten werden importiert".rjust(5)
  puts "(6)close".ljust(10) + "=>".center(10) + "Beendet das Programm".rjust(5)
  print "Eingabe: "
  choice = gets.chomp
### add
  if choice == "add" || choice == "1"
    truefalse = 0
    puts "Wie heißt die Person die Sie hinzufügen wollen?"
    personToCreate = gets.chomp
    if idCounter == 1
      arr << {:id=>idCounter, :title=>"#{personToCreate}", :parent_id=>nil}
      idCounter += 1
      output = "Die Person #{personToCreate} wurde hinzugefügt!"
    else
      puts "Zu wem wollen Sie #{personToCreate} hinzufügen? Bitte geben Sie die ID an!"
      personToAdd = gets.chomp
      arr.each do |e|
        if e[:id] == personToAdd.to_i
          arr << {:id=>idCounter, :title=>"#{personToCreate}", :parent_id=>e[:id]}
          idCounter += 1
          output = "Die Person #{personToCreate} wurde zu #{e[:title]} hinzugefügt!"
          truefalse = 1
        end
      end
      if truefalse == 0
        output = "Die ID zu der diese Person hinzugefügt werden soll, existiert nicht!"
      end
    end
### delete
  elsif choice == "delete" || choice == "2"
    truefalse = 0
    puts "Wenn wollen Sie löschen? Bitte geben Sie die ID an!"
    personToDelete = gets.chomp
    arr.each do |f|
      if f[:parent_id] == personToDelete.to_i
        truefalse = 1
      end
    end
    if truefalse == 0
      arr.delete_if {|e| e[:id] == personToDelete.to_i}
      output = "Die Person wurde gelöscht!"
    elsif truefalse == 1
      output = "Diese Person hat noch untergeordnete Personen!"
    end
### edit
  elsif choice == "edit" || choice == "3"
    puts "Wenn wollen Sie verändern? Bitte geben Sie die ID an!"
    personToChange = gets.chomp
    puts "Wie soll diese Person nun heißen?"
    givePersonNewName = gets.chomp
    arr.each do |e|
      if e[:id] == personToChange.to_i
        oldName = e[:title]
        e[:title] = "#{givePersonNewName}"
        output = "Der Name wurde von #{oldName} in #{givePersonNewName} geändert!"
      end
    end
### array
  elsif choice == "array" || choice == "999"
    output = arr
### export
  elsif choice == "export" || choice == "4"
    puts "Wie soll die Datei heißen?"
		nameOfTheFile = gets.chomp
    if File.exist?("#{nameOfTheFile}") == true
			puts "Die Datei #{nameOfTheFile} existiert bereits, soll sie überschrieben werden? (ja/nein)"
			janein_export = gets.chomp
		  if janein_export == "ja"
    		File.delete("#{nameOfTheFile}")
				myfile = File.new("#{nameOfTheFile}", "a+")
        arr.each {|e| myfile.puts(e)}
        output = "Die Datei #{nameOfTheFile} wurde erstellt"
			elsif janein_export == "nein"
				output = "Die Datei wurde nicht überschrieben!"
			else 
				output = "Überprüfen Sie ihre Eingabe!"
      end
    else
      myfile = File.new("#{nameOfTheFile}", "a+")
      myfile.puts(arr)
      output = "Die Datei #{nameOfTheFile} wurde erstellt"
    end
### import
  elsif choice == "import" || choice == "5"
    puts "Wie heißt die Datei, welche importiert werden soll?"
    nameOfTheFile = gets.chomp
    if File.exist?("#{nameOfTheFile}") == true
      puts "Sind Sie sich sicher alle momentanen Daten zu überschreiben? (ja/nein)"
      janein_import = gets.chomp
      if janein_import == "ja"
        arr = Array.new
        idCounter = 1
        File.readlines("#{nameOfTheFile}").each do |line|
          arr << eval(line)
          idCounter += 1
        end
        output = "Die Datei wurde erfolgreich importiert!"
      elsif
        output = "Die Daten wurden nicht überschrieben!"
      else
        output = "Überprüfen Sie ihre Eingabe!"
      end
    else 
      output = "Diese Datei existiert nicht!"
    end
### close
  elsif choice == "close" || choice == "6"
    ending = 1
  else
    output = "Überprüfen Sie ihre Eingabe!"
  end
end
