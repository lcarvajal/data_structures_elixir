defmodule BinarySearchTree do
  defstruct [:root]

  def init(value) do
    %BinarySearchTree{root: {value}}
  end

  def insert(%BinarySearchTree{} = tree, value) do
  end

  def traverse_and_insert(%BinarySearchTree{} = tree, {} = current_node, value) do
  end

  def search({value_to_search} = node, value_to_search), do: node
  def search({value_to_search, _} = node, value_to_search), do: node
  def search({value_to_search, _, _} = node, value_to_search), do: node

  def search({current_value, left_child_node, _right_child_node}, value_to_search)
      when value_to_search < current_value,
      do: search(left_child_node, value_to_search)

  def search({current_value, _left_child_node, right_child_node}, value_to_search)
      when value_to_search >= current_value,
      do: search(right_child_node, value_to_search)

  def search({_current_node}, value_to_search), do: nil
end

defmodule BinarySearchTreeExample do
  @moduledoc """
  Showcases the Binary search tree
  """

  def execute do
    IO.puts("Binary search tree example")

    IO.puts("Initialize with 3:")
    tree = BinarySearchTree.init(3)
    IO.inspect(tree)

    IO.puts("Find 8:")
    tree = {1, {2, {4}, {7}}, {3, {5}, {8}}}

    found_node = BinarySearchTree.search(tree, 8)
    IO.inspect(found_node)
  end
end

BinarySearchTreeExample.execute()
