#!/usr/bin/ruby

familyTreeHash = {100=>{"name"=>"Justus Siefert", "mother"=>102, "father"=>101}, 
		  101=>{"name"=>"Klaus Siefert", "mother"=>106, "father"=>105}, 
		  102=>{"name"=>"Martina Gerold", "mother"=>104, "father"=>103}, 
		  103=>{"name"=>"Heinz Gerold", "mother"=>0, "father"=>0}, 
		  104=>{"name"=>"Gisela Gerold", "mother"=>0, "father"=>0},
		  105=>{"name"=>"Gerd Siefert", "mother"=>0, "father"=>0},
	  	  106=>{"name"=>"Paula Siefert", "mother"=>0, "father"=>0}}

#familyTreeHash.each do |key, value|
#		puts "Name: " + value["name"]
#		familyTreeHash.each do |key2, value2|
#			if value["mother"] == key2
#				puts "Mutter: " + value2["name"]
#			end
#			
#			if value["father"] == key2
#				puts "Vater: " + value2["name"]
#			end
#		end
#end

familyTreeHash.each do |key, value|
	if key == 100
		puts value["name"]
		puts ""
		familyTreeHash.each do |key2, value2|
			if value["mother"] == key2
				puts value2["name"]
			end
			if value["father"] == key2
				puts value2["name"]
			end
		end
	end
end
