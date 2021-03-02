# frozen_string_literal: true

# linked list defines methods for linked list class implementation
# head tail adnb size can all be defined as
class LinkedList
  attr_reader :head

  def initialize
    @head = nil
  end

  def append(value)
    if @head.nil?
      @head = Node.new(value)
    else
      temp_node = @head
      temp_node = temp_node.next_node until temp_node.next_node.nil?
      temp_node.next_node = Node.new(value)
    end
  end

  def prepend(value)
    if @head.nil?
      @head = Node.new(value)
    else
      temp_node = @head
      @head = Node.new(value)
      @head.next_node = temp_node
    end
  end

  def tail
    if @head.nil?
      nil
    else
      temp_node = @head
      temp_node = temp_node.next_node until temp_node.next_node.nil?
      temp_node
    end
  end

  def size
    return 0 if @head.nil?

    output = 1
    temp_node = @head
    until temp_node.next_node.nil?
      temp_node = temp_node.next_node
      output += 1
    end
    output
  end

  def at(index)
    return nil if @head.nil?

    temp_node = @head
    index.times do
      break if temp_node.nil?

      temp_node = temp_node.next_node
    end
    temp_node.value
  end

  def pop
    if @head.nil?
      puts 'cannot remove node no nodes in list'
    else
      temp_node = @head
      temp_node = temp_node.next_node until temp_node.next_node.next_node.nil?
      output = temp_node.next_node
      temp_node.next_node = nil
      output.value
    end
  end

  def contains?(value)
    return false if @head.nil?

    return true if @head.value == value

    temp_node = @head
    until temp_node.next_node.nil?
      temp_node = temp_node.next_node
      return true if temp_node.value == value
    end
    false
  end

  def find(value)
    return nil? if @head.nil?

    return 0 if @head.value == value

    temp_node = @head
    output = 0
    until temp_node.next_node.nil?
      output += 1
      return output if temp_node.next_node.value == value

      temp_node = temp_node.next_node
    end
    nil
  end

  def to_s
    return '' if @head.nil?

    temp_node = @head
    output = String.new("( #{@head.value} )")
    until temp_node.next_node.nil?
      temp_node = temp_node.next_node
      output << " -> ( #{temp_node.value} )"
    end
    output << ' -> nil'
  end

  def insert_at(value, index)
    append(value) if index.zero?
    temp_node = @head
    (index - 1).times { temp_node = temp_node.next_node }
    next_next_node = temp_node.next_node
    temp_node.next_node = Node.new(value)
    temp_node.next_node.next_node = next_next_node
  end

  def remove_at(index)
    if index.zero?
      output = @head.value
      @head = @head.next_node
    else
      temp_node = @head
      (index - 1).times { temp_node = temp_node.next_node }
      output = temp_node.next_node.value
      temp_node.next_node = temp_node.next_node.next_node
    end
    output
  end
end

# Node members of linked list
class Node
  attr_accessor :value, :next_node

  def initialize(value)
    @value = value
    @next_node = nil
  end
end

list = LinkedList.new
list.append('test2').prepend('test1').append('test3').append('test4').append('test5')
p list.head.value
p list.head.next_node.value
p list.head.next_node.next_node.value
p list.size
p list.tail.value
p list.at(0)
p list.pop
p list.contains?('test3')
p list.contains?('test5')
p list.find('test2')
p list.find('not in list')
p list.to_s
list.insert_at('method test', 2)
p list.at(2)
p list.to_s
p list.remove_at(1)
p list.to_s
