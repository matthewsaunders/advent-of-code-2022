#!/usr/bin/env ruby

puts "---------------------------------"
puts " Day 03 - Problem 02"
puts "---------------------------------"

INPUT_FILE = "input.txt"
# INPUT_FILE = "input-test.txt"

lower = ('a'..'z').to_a
upper = ('A'..'Z').to_a
letters = lower + upper

PRIORITY_MAP = {}
letters.each_with_index{ |letter, index| PRIORITY_MAP[letter] = index + 1 }

class Group
  def initialize(rucksacks)
    @rucksacks = rucksacks
  end

  def find_badge
    badge = nil
    index = 0

    while !badge
      current_item = @rucksacks[0][index]

      if @rucksacks[1].index(current_item) && @rucksacks[2].index(current_item)
        badge = current_item
      end

      index += 1
    end

    badge
  end
end

def calculate_priority_score(items)
  items.inject(0) { |count, item| count + PRIORITY_MAP[item] }
end

# Read input
lines = File.readlines(INPUT_FILE)

groups = []

lines.each_slice(3) do |rucksacks|
  groups << Group.new(rucksacks)
end

total_priorities = groups.inject(0) { |sum,g| sum + PRIORITY_MAP[g.find_badge] }

puts "ANSWER: #{total_priorities}"
