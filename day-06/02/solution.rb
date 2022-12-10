#!/usr/bin/env ruby
require 'set'

puts "---------------------------------"
puts " Day 06 - Problem 02"
puts "---------------------------------"

INPUT_FILE = "input.txt"
# INPUT_FILE = "input-test.txt"

# Read input
lines = File.readlines(INPUT_FILE)

input = lines.first

index = 0
marker = nil

while !marker && index < input.length - 4
  set = Set.new

  (0..13).each do |i|
    set << input[index + i]
  end

  if set.to_a.length == 14
    marker = index + 14
  end

  index += 1
end

puts "ANSWER: #{marker}"
