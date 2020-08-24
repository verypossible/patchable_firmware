defmodule PatchableTestTest do
  use ExUnit.Case
  doctest PatchableTest

  test "greets the world" do
    assert PatchableTest.hello() == :world
  end
end
