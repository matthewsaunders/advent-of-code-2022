#!/usr/bin/env ruby

puts "---------------------------------"
puts " Day 02 - Problem 01"
puts "---------------------------------"

INPUT_FILE = "input.txt"
# INPUT_FILE = "input-test.txt"

class Contest
  def initialize(opponent_move, my_move)
    @opponent_move = opponent_move
    @my_move = my_move
  end

  def score
    score = 0

    # Add score for my move
    case @my_move
    when 'X'
      score += 1
    when 'Y'
      score += 2
    when 'Z'
      score += 3
    end

    # Add score for outcome
    if draw?
      score += 3
    elsif my_win?
      score += 6
    end

    score
  end

  def my_win?
    @my_move == 'X' && @opponent_move == 'C' || # rock beats scissors
    @my_move == 'Y' && @opponent_move == 'A' || # paper beats rock
    @my_move == 'Z' && @opponent_move == 'B' # scissors beats paper
  end

  def draw?
    @my_move == 'X' && @opponent_move == 'A' ||
    @my_move == 'Y' && @opponent_move == 'B' ||
    @my_move == 'Z' && @opponent_move == 'C'
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
