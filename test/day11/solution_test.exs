defmodule Aoc2022.Day11Test do
  use ExUnit.Case

  alias Aoc2022.Day11
  alias Aoc2022.Day11.Part1
  alias Aoc2022.Day11.Part2

  @test_input File.read!("test/day11/input.txt")

  describe "Day11" do
    test "Part1" do
      assert 10605 == @test_input |> Part1.solve()
    end

    test "Part2" do
      assert 2713310158 == @test_input |> Part2.solve()
    end
  end
end
