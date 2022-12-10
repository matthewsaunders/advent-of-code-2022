#!/usr/bin/env ruby

puts "---------------------------------"
puts " Day 05 - Problem 02"
puts "---------------------------------"

INPUT_FILE = "input.txt"
# INPUT_FILE = "input-test.txt"

class Ship
  def initialize(num_stacks)
    @stacks = []
    num_stacks.times do
      @stacks << []
    end
  end

  def add_item(column, item)
    @stacks[column].unshift(item)
  end

  def move_items(num_items, from, to)
    end_index = @stacks[from].length
    start_index = end_index - num_items

    to_move = @stacks[from][start_index..end_index]
    @stacks[from] = @stacks[from][0..start_index - 1]

    to_move.each { |item| @stacks[to].push(item) }
  end

  def top_of_stacks
    @stacks.map(&:last).join('')
  end

  def stacks
    @stacks
  end

  def print_state
    @stacks.each_with_index do |stack, index|
      puts "#{index}: #{stack.join('-')}"
    end
    puts ""
  end
end

# Read input
lines = File.readlines(INPUT_FILE)

initial_state = []
moves = []

lines.each do |line|
  next if line == "\n"

  if line.start_with?('move')
    moves << line
  else
    initial_state << line
  end
end

COL_WIDTH = 3
COL_SPACE_WIDTH = 4

num_columns = initial_state.pop.split(' ').length
ship = Ship.new(num_columns)

# Parse initial state
initial_state.each do |line|
  index = 0
  column = 0

  while (column * COL_SPACE_WIDTH) < line.length
    start_index = column * COL_SPACE_WIDTH
    end_index = start_index + 2
    item = line[start_index..end_index].strip
    # puts "--> #{item} - column: #{column}, start_index: #{start_index}, end_index: #{end_index}"

    if item != ""
      ship.add_item(column, item[1])
    end

    column += 1
  end
end

# ship.print_state

# Apply operations
moves.each do |move|
  parts = move.split(' ')
  ship.move_items(parts[1].to_i, parts[3].to_i - 1, parts[5].to_i - 1)
  # ship.print_state
end

puts "ANSWER: #{ship.top_of_stacks}"
