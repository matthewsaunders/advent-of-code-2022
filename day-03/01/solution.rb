#!/usr/bin/env ruby

puts "---------------------------------"
puts " Day 03 - Problem 01"
puts "---------------------------------"

INPUT_FILE = "input.txt"
# INPUT_FILE = "input-test.txt"

lower = ('a'..'z').to_a
upper = ('A'..'Z').to_a
letters = lower + upper

PRIORITY_MAP = {}
letters.each_with_index{ |letter, index| PRIORITY_MAP[letter] = index + 1 }

class Rucksack
  def initialize(items)
    middle = items.length / 2
    @left = items.slice(0, middle).split('')
    @right = items.slice(middle, items.length).split('')
  end

  def items_in_left_and_right
    items_count = {}
    items_in_both = []

    @left.each { |item| items_count[item] = 1 }
    @right.each { |item| items_count[item] = 2 if items_count[item] == 1 }
    items_count.each_key { |item| items_in_both << item if items_count[item] == 2 }

    items_in_both
  end
end

def calculate_priority_score(items)
  items.inject(0) { |count, item| count + PRIORITY_MAP[item] }
end

# Read input
lines = File.readlines(INPUT_FILE)

rucksacks = []

lines.each do |line|
  rucksacks << Rucksack.new(line)
end

total_count = rucksacks.inject(0) { |count, r| count + calculate_priority_score(r.items_in_left_and_right) }

puts "ANSWER: #{total_count}"
