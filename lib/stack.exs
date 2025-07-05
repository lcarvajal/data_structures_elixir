defmodule Stack do
  @moduledoc """
  A stack is a data structure with first in, last out.
  You can think of it as a stack of plates, where the first plate stacked is the last to get unstacked.
  """

  @doc """
  Given a stack and value, pushes the value to the stack.

  Returns a stack with the value pushed to the front of it.

  ## Examples

      iex> Stack.push([], 1)
      [1]
  """
  def push(stack, value) do
    [value | stack]
  end

  @doc """
  Pops the first item from the stack.

  Returns `{first_item, remaining_stack}` if list is nonempty.

  Returns `{nil, []}` if list is empty.

  ## Examples

      iex> Stack.pop([1,2,3])
      {1, [2,3]}

      iex> Stack.pop([])
      {nil, []}

  """
  def pop(stack) do
    case stack do
      [] ->
        {nil, []}

      _ ->
        [head | tail] = stack
        {head, tail}
    end
  end

  @doc """
  Given a stack, returns the first value.

  ## Examples

      iex> Stack.peek([1,2,3])
      1

      iex> Stack.peek([])
      nil

  """
  def peek(stack) do
    case stack do
      [] -> nil
      _ -> hd(stack)
    end
  end

  @doc """
  Given a stack, returns true if the stack is empty.

  Returns `boolean`.

  ## Examples

      iex> Stack.empty?([])
      true

  """
  def empty?(stack) do
    peek(stack) == nil
  end
end

defmodule StackExample do
  @moduledoc """
  Showcases the Stack
  """

  def execute do
    stack = [2, 3]

    IO.puts("Result:")

    pushed_stack = Stack.push(stack, 1)
    IO.inspect(pushed_stack)

    popped_stack = Stack.pop(stack)
    IO.inspect(popped_stack)

    popped_empty_stack = Stack.pop([])
    IO.inspect(popped_empty_stack)

    peeked_stack = Stack.peek(stack)
    IO.inspect(peeked_stack)

    peeked_empty_stack = Stack.peek([])
    IO.inspect(peeked_empty_stack)

    empty_stack = Stack.empty?(stack)
    IO.inspect(empty_stack)
  end
end
