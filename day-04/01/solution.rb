#!/usr/bin/env ruby

puts "---------------------------------"
puts " Day 04 - Problem 01"
puts "---------------------------------"

INPUT_FILE = "input.txt"
# INPUT_FILE = "input-test.txt"

class Pair
  def initialize(assignments)
    @first = parse_assignment(assignments[0])
    @second = parse_assignment(assignments[1])
  end

  def contains_redundant_assignment?
    min = [@first[0], @second[0]].min
    max = [@first[1], @second[1]].max

    (@first[0] == min && @first[1] == max) || (@second[0] == min && @second[1] == max)
  end

  private

  def parse_assignment(data)
    data.split('-').map(&:to_i)
  end
end

# Read input
lines = File.readlines(INPUT_FILE)

pairs = []

lines.each do |line|
  pairs << Pair.new(line.split(','))
end

count = pairs.inject(0) { |sum, pair| pair.contains_redundant_assignment? ? sum + 1 : sum }

puts "ANSWER: #{count}"
