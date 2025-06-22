defmodule LinkedListNode do
  defstruct [:value, :pointer]
end

defmodule LinkedList do
  defstruct head: nil

  @doc """
  Initializes an empty LinkedList.

  ## Examples

      iex> LinkedList.init()
      %LinkedList{head: nil}
  """
  def init do
    %LinkedList{head: nil}
  end

  @doc """
  Checks if the linked list contains a node.

  Returns `boolean`

  ## Examples
    
      iex> linked_list = LinkedList.init()
      iex> LinkedList.empty?(linked_list)
      true

      iex> node_1 = %LinkedListNode{value: 1, pointer: nil }
      iex> linked_list = %LinkedList{head: node_1}
      iex> LinkedList.empty?(linked_list)
      false
  """
  def empty?(%LinkedList{head: head}), do: head == nil

  @doc """
  Returns the first value of the LinkedList if it exists.

  ## Examples

    iex> linked_list = %LinkedList{head: %LinkedListNode{value: "hello", pointer: nil}}
    iex> LinkedList.head(linked_list)
    hello
  """
  def head(%LinkedList{head: %LinkedListNode{value: value}}), do: value

  @doc """
  Removes the first node of the linked list and returns the remaining list.

  ## Examples
      
      iex> linked_list = %LinkedList{ head: nil }
      iex> linked_list = LinkedList.prepend(linked_list, "world")
      iex> linked_list = LinkedList.prepend(linked_list, "Hello, "
      iex> linked_list = LinkedList.remove_head(linked_list)
      iex> linked_list.head.value
      world
  """
  def remove_head(%LinkedList{head: %LinkedListNode{value: _value, pointer: new_head}}),
    do: %LinkedList{head: new_head}

  @doc """
  Returns the last value of the linked list if it exists.

  ## Examples 

      iex> node_2 = %LinkedListNode{value: 2, pointer: nil }
      iex> node_1 = %LinkedListNode{value: 1, pointer: node_2 }
      iex> linked_list = %LinkedList{head: node_1}
      iex> LinkedList.tail(linked_list)
      2

      iex> node_1 = %LinkedListNode{value: 1, pointer: nil }
      iex> linked_list = %LinkedList{head: node_1}
      iex> LinkedList.tail(linked_list)
      1
  """
  def tail(%LinkedList{head: existing_head}) do
    tail_node = traverse_to_tail_node(existing_head)
    tail_node.value
  end

  # Traverses a linked list to its final node.
  defp traverse_to_tail_node(%LinkedListNode{value: tail_value, pointer: nil}),
    do: %LinkedListNode{value: tail_value, pointer: nil}

  defp traverse_to_tail_node(%LinkedListNode{value: _value, pointer: next_node}),
    do: traverse_to_tail_node(next_node)

  @doc """
  Prepends a value to a linked list.

  ## Examples

      iex> linked_list = %LinkedList{ head: nil }
      iex> linked_list_with_one_node = LinkedList.prepend(linked_list, "world")
      world
      iex> linked_list_with_two_nodes = LinkedList.prepend(linked_list_with_one_node, "Hello, "
      Hello, world
  """
  def prepend(%LinkedList{head: nil}, value) do
    node = %LinkedListNode{value: value, pointer: nil}
    %LinkedList{head: node}
  end

  def prepend(%LinkedList{head: existing_head}, value) do
    node = %LinkedListNode{value: value, pointer: existing_head}
    %LinkedList{head: node}
  end

  @doc """
  Appends a value to the end of a linked list.

  ## Examples

      iex> linked_list = LinkedList.init()
      iex> linked_list = LinkedList.append(1)
      iex> linked_list = LinkedList.append(linked_list, 2)
      iex> LinkedList.tail(linked_list)
      2
  """
  def append(%LinkedList{head: nil}, value) do
    node = %LinkedListNode{value: value, pointer: nil}
    %LinkedList{head: node}
  end

  def append(%LinkedList{} = original_list, value) do
    reversed_list = reverse(original_list)
    reversed_list = prepend(reversed_list, value)
    reverse(reversed_list)
  end

  @doc """

  Returns the linked list in reverse order.

  ## Examples

      iex> linked_list = LinkedList.init()
      iex> linked_list = LinkedList.append(1)
      iex> linked_list = LinkedList.append(linked_list, 2)
      iex> reversed_list = LinkedList.reverse(linked_list)
      iex> LinkedList.head(reversed_list)
      2

  """
  def reverse(%LinkedList{head: head}) do
    empty_list = init()
    traverse_and_prepend(empty_list, head)
  end

  # Traverses a linked list with the current_node while prepending copies to acc.
  defp traverse_and_prepend(
         %LinkedList{} = acc,
         %LinkedListNode{pointer: nil} = current_node
       ),
       do: prepend(acc, current_node.value)

  defp traverse_and_prepend(
         %LinkedList{} = acc,
         %LinkedListNode{} = current_node
       ) do
    prepended_list = prepend(acc, current_node.value)
    traverse_and_prepend(prepended_list, current_node.pointer)
  end
end

defmodule LinkedListExample do
  def execute do
    linked_list = LinkedList.init()
    IO.puts("Original linked list:")
    IO.inspect(linked_list)

    IO.puts("Is it empty?")
    IO.inspect(LinkedList.empty?(linked_list))

    IO.puts("Prepend 3, 2, and then 1... to get 1 -> 2 -> 3")
    linked_list = LinkedList.prepend(linked_list, 3)
    linked_list = LinkedList.prepend(linked_list, 2)
    linked_list = LinkedList.prepend(linked_list, 1)
    IO.inspect(linked_list)

    IO.puts("Reversed without changing:")
    IO.inspect(LinkedList.reverse(linked_list))

    IO.puts("Head value:")
    IO.inspect(LinkedList.head(linked_list))

    IO.puts("Tail value:")
    IO.inspect(LinkedList.tail(linked_list))

    IO.puts("Is it empty?")
    IO.inspect(LinkedList.empty?(linked_list))

    IO.puts("Remove first node:")
    linked_list = LinkedList.remove_head(linked_list)
    IO.inspect(linked_list)

    IO.puts("Adds `hello` to end. Displaying tail:")
    linked_list = LinkedList.append(linked_list, "hello")
    IO.inspect(LinkedList.tail(linked_list))
  end
end

LinkedListExample.execute()
