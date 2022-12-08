#!/usr/bin/env ruby

puts "---------------------------------"
puts " Day 01 - Problem 02"
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

def remove_max_elf(elves)
  max_elf = elves.first
  max_elf_index = 0

  elves.each_with_index do |elf, index|
    if elf.total_calories > max_elf.total_calories
      max_elf = elf
      max_elf_index = index
    end
  end

  elves.delete_at(max_elf_index)
  [max_elf, elves]
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

elf1, elves = remove_max_elf(elves)
elf2, elves = remove_max_elf(elves)
elf3, elves = remove_max_elf(elves)

puts "ANSWER: #{elf1.total_calories + elf2.total_calories + elf3.total_calories}"
