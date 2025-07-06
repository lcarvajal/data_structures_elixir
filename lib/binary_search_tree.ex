defmodule DsEx.BinarySearchTree do
  @moduledoc """
  A binary search tree stores values in a way such that the left child nodes are all less than the value of the current node.

  The way we pass the tree is using a map: `{value, left_child_node, right_child_node}`, where child nodes are also trees themselves.
  """

  @doc """
  Initializes a tree with a value.

  ## Examples
      iex> BinarySearchTree.init_tree(3)
      {3, nil, nil}

  """
  def init_tree(value) do
    {value, nil, nil}
  end

  @doc """
  Traverses the tree to insert a value so that all left child nodes are less than the value of any parent / grandparent node.

  ## Examples
    iex> tree = BinarySearchTree.init_tree(3)
    iex> tree = BinarySearchTree.insert(tree, 4)
    {3, nil, {4, nil, nil}}
    iex> tree = BinarySearchTree.insert(tree, 2)
    {3, {2, nil, nil}, {4, nil, nil}}
    iex> BinarySearchTree.insert(tree, 5)
    {3, {2, nil, nil}, {4, nil, {5, nil, nil}}}
  """
  def insert({current_value, nil, nil}, value_to_insert) when value_to_insert < current_value,
    do: {current_value, init_tree(value_to_insert), nil}

  def insert({current_value, nil, nil}, value_to_insert) when value_to_insert >= current_value,
    do: {current_value, nil, init_tree(value_to_insert)}

  def insert({_, _, _} = tree, value_to_insert),
    do: traverse_tree_for_insert(tree, [{tree, 0}], value_to_insert)

  defp traverse_tree_for_insert(
         {current_value, left_child_node, right_child_node},
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

  defp rebuild_tree([{final_tree, _}]), do: final_tree

  defp rebuild_tree([{current_node, side_index}, {parent_node, _}]) do
    replaced_parent_node = {put_elem(parent_node, side_index, current_node), 0}
    rebuild_tree([replaced_parent_node])
  end

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
      iex> tree = {5, {3, {2, nil, nil}, {4, nil, nil}}, {8, {6, nil, nil}, {9, nil, nil}}}
      iex> BinarySearchTree.search(tree, 8)
      {8, {6, nil, nil}, {9, nil, nil}}
      iex> BinarySearchTree.search(tree, 2)
      {2, nil, nil}
       
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

defmodule DsEx.BinarySearchTreeExample do
  @moduledoc """
  Showcases the Binary search tree
  """

  import DsEx.BinarySearchTree

  def execute do
    IO.puts("Binary search tree example")

    IO.puts("Initialize with 3:")
    tree = init_tree(3)
    IO.inspect(tree)

    IO.puts("Insert 4:")
    tree = insert(tree, 4)
    IO.inspect(tree)

    IO.puts("Insert 2:")
    tree = insert(tree, 2)
    IO.inspect(tree)

    IO.puts("Start with a larger tree")
    tree = {5, {3, {2, nil, nil}, {4, nil, nil}}, {8, {6, nil, nil}, {9, nil, nil}}}
    IO.inspect(tree)

    IO.puts("Find 8:")
    found_node = search(tree, 8)
    IO.inspect(found_node)

    IO.puts("Insert 10:")
    traversed = insert(tree, 10)
    IO.inspect(traversed)
  end
end
