#!/usr/bin/env ruby

require_relative('lib/rover')

puts
puts "Enter info of rover you want to purchase"

puts

print "Make:"
make = gets.chomp 

print "Year:"
year = gets.chomp

print "Color:"
color = gets.chomp

print "Planet:"
planet = gets.chomp

print "Door:"
door = gets.chomp

rover = Rover.new(:make => make , :year => year , :color => color , :planet => planet)

puts
puts "I understand you want to purchase: #{rover.full_name} ."
puts 
puts "\t\t\t Eric Caleb | Shadowscript | 2016"
puts
