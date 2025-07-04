defmodule Queue do
  @moduledoc """
  A queue has the first in, first out principle. 

  The first element added is the first one removed.

  For example, waiting for a ticket at the London Underground means waiting on a queue. First person who arrives is the first person served.
  """

  @doc """
  Initializes an empty queue

  Returns `[]`.

  ## Examples

      iex> Queue.init()
      []
  """
  def init do
    []
  end

  @doc """
  Enqueues or adds a value to the queue.

  Returns the queue with the value appended to it.

      iex> Queue.enqueue([], 1)
      [1]
  """
  def enqueue(queue, value) do
    queue ++ [value]
  end

  @doc """
  Dequeues or removes the first value from a queue.

  Returns `{queue, value}` if queue is nonempty.

  Returns `{queue, nil}` is queue is empty.

  ## Examples

      iex> Queue.dequeue([])
      nil

      iex> Queue.dequeue([1,2])
      {[2], 1}

  """
  def dequeue(queue) do
    case queue do
      [] ->
        {[], nil}

      [value | queue] ->
        {queue, value}
    end
  end

  @doc """
  Returns the first value of a queue without making making any changes to the queue.

  Returns `nil` if the queue is empty.

  ## Examples

      iex> Queue.peek([1,2,3])
      1

      iex> Queue.peek([])
      nil

  """
  def peek(queue) do
    case queue do
      [] -> nil
      _ -> hd(queue)
    end
  end

  @doc """
  Checks if the queue is empty.

  Returns `boolean`

  ## Examples

      iex> Queue.empty?([])
      true

      iex> Queue.empty?([1,2,3])
      false

  """
  def empty?(queue) do
    peek(queue) == nil
  end

  @doc """
  Returns the number of items in the queue.

  ## Examples

      iex> Queue.length_of([])
      0

      iex> Queue.length_of([1])
      1

      iex> Queue.length_of([1,2,3])
      3
  """
  def length_of(queue) do
    length(queue)
  end
end

defmodule QueueExample do
  @moduledoc """
  Showcases the Queue
  """

  def execute do
    IO.puts("Init:")
    q = Queue.init()
    IO.inspect(q)

    IO.puts("Enqueue 1 and 2:")
    q = Queue.enqueue(q, 1)
    q = Queue.enqueue(q, 2)
    IO.inspect(q)

    IO.puts("Dequeue:")
    {q, first} = Queue.dequeue(q)
    IO.inspect(q)
    IO.inspect(first)

    IO.puts("Peek:")
    first = Queue.peek(q)
    IO.inspect(first)
    IO.inspect(q)

    IO.puts("Size:")
    IO.inspect(Queue.length_of(q))
  end
end
