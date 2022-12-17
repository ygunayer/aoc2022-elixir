defmodule Aoc2022.Day01Test do
  use ExUnit.Case

  alias Aoc2022.Day01.Part1
  alias Aoc2022.Day01.Part2

  @test_input File.read!("test/day01/input.txt")

  describe "Day01" do
    test "Part1" do
      assert 24000 == @test_input |> Part1.solve()
    end

    test "Part2" do
      assert 45000 == @test_input |> Part2.solve()
    end
  end
end
