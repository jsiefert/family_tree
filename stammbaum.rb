#!/usr/bin/ruby

puts "Wer bist du?"
firstMember = gets.chomp
familyTreeHash = Hash.new
familyTreeHash[firstMember] = {"name" => firstMember, "id" => 100}

ending = 0
counter = 101

while ending != 1
	puts "Was möchten Sie tun?".center(40)
	puts "Mitglied bearbeiten".ljust(20) + "=>".center(10) + "change".rjust(10)
	puts "Mitglied hinzufügen".ljust(20) + "=>".center(10) + "add".rjust(10)
	puts "Mitglied löschen".ljust(20) + "=>".center(10) + "delete".rjust(10)	
	puts "Stammbaum anzeigen".ljust(20) + "=>".center(10) + "show".rjust(10)
	puts "Das Programm beenden".ljust(20) + "=>".center(10) + "end".rjust(10)
	choice = gets.chomp
	
	if choice == "add"
		puts "Wer bist du?"
		you = gets.chomp
		puts "Von wem bist du ein Elternteil?"
		from = gets.chomp
		
		counter +=1	
	elsif choice == "show"
		puts familyTreeHash
	elsif choice == "end"
		ending = 1
	end
end
