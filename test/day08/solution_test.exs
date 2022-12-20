defmodule Aoc2022.Day08Test do
  use ExUnit.Case

  alias Aoc2022.Day08
  alias Aoc2022.Day08.Part1
  alias Aoc2022.Day08.Part2

  @test_input File.read!("test/day08/input.txt")

  describe "Day08" do
    test "Part1" do
      assert 21 == @test_input |> Part1.solve()
    end

    test "Part2" do
      assert 8 == @test_input |> Part2.solve()
    end
  end
end
