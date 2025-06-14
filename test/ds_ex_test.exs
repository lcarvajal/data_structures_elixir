defmodule DsExTest do
  use ExUnit.Case
  doctest DsEx

  test "greets the world" do
    assert DsEx.hello() == :world
  end
end
