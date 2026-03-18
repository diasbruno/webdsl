defmodule WebdslTest do
  use ExUnit.Case
  doctest Webdsl

  test "greets the world" do
    assert Webdsl.hello() == :world
  end
end
