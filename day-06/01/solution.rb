#!/usr/bin/env ruby
require 'set'

puts "---------------------------------"
puts " Day 06 - Problem 01"
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

  set << input[index]
  set << input[index + 1]
  set << input[index + 2]
  set << input[index + 3]

  if set.to_a.length == 4
    marker = index + 4
  end

  index += 1
end

puts "ANSWER: #{marker}"
