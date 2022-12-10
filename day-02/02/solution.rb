#!/usr/bin/env ruby

puts "---------------------------------"
puts " Day 02 - Problem 01"
puts "---------------------------------"

INPUT_FILE = "input.txt"
# INPUT_FILE = "input-test.txt"

class Contest
  MOVES = %w(A B C)

  def initialize(opponent_move, outcome)
    @opponent_move = opponent_move
    @outcome = outcome
  end

  def score
    score = 0
    my_move = determine_my_move

    # Add score for my move
    case my_move
    when 'A'
      score += 1
    when 'B'
      score += 2
    when 'C'
      score += 3
    end

    # Add score for outcome
    case @outcome
    when 'Z'
      score += 6
    when 'Y'
      score += 3
    end

    # puts "(#{@opponent_move}, #{my_move}, #{@outcome}) -> #{score}"

    score
  end

  def determine_my_move
    return @opponent_move if @outcome == 'Y' # draw

    opponent_move_index = MOVES.index(@opponent_move)
    my_move_index = (opponent_move_index + (@outcome == 'Z' ? 1 : -1)) % MOVES.length

    MOVES[my_move_index]
  end
end

# Read input
lines = File.readlines(INPUT_FILE)

contests = []

lines.each do |line|
  parts = line.split(' ')
  contests << Contest.new(parts[0], parts[1])
end

total_score = contests.map(&:score).inject(0, :+)

puts "ANSWER: #{total_score}"
