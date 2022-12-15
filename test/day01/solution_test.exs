defmodule Aoc2022.Day01Test do
  use ExUnit.Case

  alias Aoc2022.Day01.Part1

  @test_input1 ""

  describe "Day 01 - Part 1" do
    test "foo" do
      assert 42 == @test_input1 |> Part1.solve()
    end
  end
end
