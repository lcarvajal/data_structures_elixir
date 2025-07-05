defmodule BinarySearchTree do
  @moduledoc """
  A binary search tree stores values in a way such that the left child nodes are all less than the value of the current node.
  """

  def init(value) do
    {value, nil, nil}
  end

  def insert({current_value, nil, nil}, value_to_insert) when value_to_insert < current_value,
    do: {current_value, BinarySearchTree.init(value_to_insert), nil}

  def insert({current_value, nil, nil}, value_to_insert) when value_to_insert >= current_value,
    do: {current_value, nil, BinarySearchTree.init(value_to_insert)}

  def insert({_, _, _} = tree, value_to_insert) do
    traverse_tree_for_insert(tree, [{tree, 0}], value_to_insert)
  end

  defp traverse_tree_for_insert(
         {current_value, left_child_node, right_child_node} = tree,
         [_last_traversed_node | first_traversed_nodes] = traversed_nodes,
         value_to_insert
       ) do
    cond do
      value_to_insert < current_value && left_child_node ->
        node_with_side = [{left_child_node, 1}]
        traversed_nodes = node_with_side ++ traversed_nodes
        traverse_tree_for_insert(left_child_node, traversed_nodes, value_to_insert)

      value_to_insert < current_value ->
        new_node = {value_to_insert, nil, nil}
        node_to_replace = {{current_value, new_node, right_child_node}, 1}
        rebuild_tree([node_to_replace] ++ first_traversed_nodes)

      value_to_insert >= current_value && right_child_node ->
        node_with_side = [{right_child_node, 2}]
        traversed_nodes = node_with_side ++ traversed_nodes
        traverse_tree_for_insert(right_child_node, traversed_nodes, value_to_insert)

      value_to_insert >= current_value ->
        new_node = {value_to_insert, nil, nil}
        node_to_replace = {{current_value, left_child_node, new_node}, 2}
        rebuild_tree([node_to_replace] ++ first_traversed_nodes)
    end
  end

  defp rebuild_tree([{final_tree, 0}]), do: final_tree

  defp rebuild_tree([
         {current_node, side_index},
         {parent_node, parent_side_index} | first_traversed_nodes
       ]) do
    replaced_parent_node = {put_elem(parent_node, side_index, current_node), parent_side_index}
    rebuild_tree([replaced_parent_node] ++ first_traversed_nodes)
  end

  @doc """
  Searchs the tree for a value by starting from the root node.
  If the searched value is less than the root node value, it will continue with the left child node.
  If the searched value is greater than or equal, then the right.

  Returns the node containing the searched value if it exists. Otherwise nil.

  ## Examples
      iex> tree = {1, {2, {4, nil, nil}, {7, nil, nil}}, {3, {5, nil, nil}, {8, nil, nil}}}
      iex> BinarySearchTree.search(tree, 8)
      {8, nil, nil}
      iex> BinarySearchTree.search(tree, 2)
      {2, {4, nil, nil}, {7, nil, nil}}
       
  """
  def search({value_to_search, _, _} = node, value_to_search), do: node

  def search({current_value, left_child_node, _right_child_node}, value_to_search)
      when value_to_search < current_value,
      do: search(left_child_node, value_to_search)

  def search({current_value, _left_child_node, right_child_node}, value_to_search)
      when value_to_search >= current_value,
      do: search(right_child_node, value_to_search)

  def search({_, _, _}, _), do: nil
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

    IO.puts("Insert 4:")
    tree = BinarySearchTree.insert(tree, 4)
    IO.inspect(tree)

    IO.puts("Start with a larger tree")
    tree = {1, {2, {4, nil, nil}, {7, nil, nil}}, {3, {5, nil, nil}, {8, nil, nil}}}
    IO.inspect(tree)

    IO.puts("Find 8:")
    found_node = BinarySearchTree.search(tree, 8)
    IO.inspect(found_node)

    IO.puts("Insert 10:")
    traversed = BinarySearchTree.insert(tree, 10)
    IO.inspect(traversed)
  end
end

BinarySearchTreeExample.execute()
