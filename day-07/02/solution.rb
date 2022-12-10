#!/usr/bin/env ruby

puts "---------------------------------"
puts " Day 07 - Problem 02"
puts "---------------------------------"

INPUT_FILE = "input.txt"
# INPUT_FILE = "input-test.txt"

class DirectoryNode
  def initialize(name: "", children: [], parent: nil)
    @name = name
    @children = children
    @parent = parent
  end

  def parent
    @parent
  end

  def name
    @name
  end

  def children
    @children
  end

  def add_child(node)
    @children << node
  end

  def child_directory_nodes
    @children.filter { |c| c.class == DirectoryNode }
  end

  def find_or_create_child_directory(name)
    node = child_directory_nodes.find { |c| c.name == name }

    if !node
      node = DirectoryNode.new(name: name, parent: self)
      add_child(node)
    end

    node
  end

  def size
    @children.inject(0) { |sum, c| sum + c.size }
  end

  def print(space: "")
    puts "#{space}- #{@name} (dir)"

    @children.each { |c| c.print(space: "  #{space}") }
  end
end

class FileNode
  def initialize(name: "", size: 0, parent: nil)
    @name = name
    @size = size
    @parent = parent
  end

  def parent
    @parent
  end

  def name
    @name
  end

  def size
    @size
  end

  def print(space: "")
    puts "#{space}- #{@name} (file, size=#{@size})"
  end
end

# Read input
lines = File.readlines(INPUT_FILE)
index = 0

ROOT_NODE = DirectoryNode.new(name: "/")
current_node = ROOT_NODE

# Parse and execute commands
while index < lines.length
  current_line = lines[index]
  parts = current_line.split(' ')
  command = parts[1]

  # puts "--> #{current_line}"

  case command
  when "cd"
    location = parts[2]

    if location == "/"
      current_node = ROOT_NODE
    elsif location == ".."
      current_node = current_node.parent
    else
      current_node = current_node.find_or_create_child_directory(location)
    end

    index += 1
  when "ls"
    index += 1
    current_line = lines[index]

    while index < lines.length && current_line[0] != "$"
      partz = current_line.split(" ")

      if partz[0] == "dir"
        node = DirectoryNode.new(name: partz[1], parent: current_node)
      else
        node = FileNode.new(name: partz[1], parent: current_node, size: partz[0].to_i)
      end

      current_node.add_child(node)
      index += 1
      current_line = lines[index]
    end
  end
end

# Calculate answer
nodes = []
current_node = ROOT_NODE
sizes = []

while current_node != nil
  nodes += current_node.child_directory_nodes if current_node.class == DirectoryNode
  sizes << current_node.size
  current_node = nodes.pop
end

TOTAL_SPACE = 70000000
REQUIRED_SPACE = 30000000
total_size = ROOT_NODE.size
space_remaining = TOTAL_SPACE - total_size
space_needed_to_delete = REQUIRED_SPACE - space_remaining

sizes = sizes.sort.reverse
dir_size_to_delete = nil

while !dir_size_to_delete && sizes.length > 0
  size = sizes.pop

  if size > space_needed_to_delete
    dir_size_to_delete = size
  end
end

puts "ANSWER: #{dir_size_to_delete}"
