# frozen_string_literal: true

# Node defines nodes in binary search tree
class Node
  include Comparable
  attr_accessor :right, :left, :data

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  def <=>(other)
    return @data <=> other.data if other.instance_of? Node

    @data <=> other
  end
end

# Tree defines the binary search tree of Node instances and it's methods
class Tree
  attr_reader :root

  def initialize(array)
    array = array.uniq.sort
    @root = build_tree(array)
  end

  def build_tree(array)
    return nil if array.empty?

    middle = array.length / 2
    node = Node.new(array[middle])
    node.left = build_tree(array[0, middle])
    node.right = build_tree(array[middle + 1, middle])
    node
  end

  def insert(data, root = @root)
    if data == root
      puts 'Value already present in tree'
    elsif root < data
      root.right.nil? ? (return root.right = Node.new(data)) : insert(data, root.right)
    elsif temp_node > data
      root.left.nil? ? (return root.left = Node.new(data)) : insert(data, root.left)
    end
  end

  def delete_node(data, root = @root)
    return nil if root.nil?

    if root < data
      root.right = delete_node(data, root.right)
    elsif root > data
      root.left = delete_node(data, root.left)
    else
      return root.right if root.left.nil?

      return root.left if root.right.nil?

      smallest_bigger_node = min_value_node(root.right)
      root.data = smallest_bigger_node.data
      delete_node(smallest_bigger_node.data, root.right)
    end
    root
  end

  def min_value_node(node)
    temp_node = node
    temp_node = temp_node.left until temp_node.left.nil?
    temp_node
  end

  def find(data, root = @root)
    return root if data == root

    if root < data
      root.right.nil? ? (return nil) : find(data, root.right)
    elsif root > data
      root.left.nil? ? (return nil) : find(data, root.left)
    end
  end

  def level_order(root = @root)
    queue = []
    output = []
    queue.push root
    until queue.empty?
      temp = queue.shift
      queue.push temp.left if temp.left
      queue.push temp.right if temp.right
      output << temp.data
    end
    output
  end

  def inorder(root = @root, array = [])
    array = inorder(root.left, array) if root.left
    array << root.data
    array = inorder(root.right, array) if root.right
    array
  end

  def preorder(root = @root, array = [])
    array << root.data
    array = preorder(root.left, array) if root.left
    array = preorder(root.right, array) if root.right
    array
  end

  def postorder(root = @root, array = [])
    array = postorder(root.left, array) if root.left
    array = postorder(root.right, array) if root.right
    array << root.data
  end

  def height(node)
    return -1 if node.nil?

    [height(node.left), height(node.left)].max + 1
  end

  def depth(node)
    temp_node = @root
    depth = 0
    until temp_node == node
      temp_node = temp_node > node ? temp_node.left : temp_node.right
      depth += 1
    end
    depth
  end

  def balanced?(node = @root)
    return true if node.nil?

    return false if (height(node.left) - height(node.right)).abs > 1

    return true unless balanced?(node.left) && balanced?(node.right)

    false
  end

  def rebalance
    @root = build_tree(inorder)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

tree = Tree.new(15.times.map { rand(100) })
tree.balanced?
puts tree.level_order.join(', ')
puts tree.preorder.join(', ')
puts tree.postorder.join(', ')
puts tree.inorder.join(', ')
tree.insert(101)
tree.insert(102)
tree.insert(103)
puts tree.balanced?
tree.rebalance
puts tree.balanced?
tree.pretty_print
puts tree.level_order.join(', ')
puts tree.preorder.join(', ')
puts tree.postorder.join(', ')
puts tree.inorder.join(', ')
