#!/usr/bin/env ruby

puts "---------------------------------"
puts " Day 01 - Problem 01"
puts "---------------------------------"

INPUT_FILE = "input.txt"

class Elf
  def initialize
    @supplies = []
  end

  def add_item(calories)
    @supplies << calories
  end

  def total_calories
    @supplies.inject(0, :+)
  end
end

# Read input
lines = File.readlines(INPUT_FILE)
elves = []

current_elf = Elf.new
elves << current_elf

# Process input
lines.each do |line|
  if line == "\n"
    current_elf = Elf.new
    elves << current_elf
  else
    current_elf.add_item(line.to_i)
  end
end

calorie_counts = elves.map(&:total_calories)
puts "ANSWER: #{calorie_counts.max}"
