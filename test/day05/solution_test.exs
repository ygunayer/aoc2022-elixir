defmodule Aoc2022.Day05Test do
  use ExUnit.Case

  alias Aoc2022.Day05
  alias Aoc2022.Day05.Part1
  alias Aoc2022.Day05.Part2
  alias Aoc2022.Day05.State

  @test_input File.read!("test/day05/input.txt")

  describe "Day05" do
    test "parse_input/1" do

      expected_layout = %State{
        columns: [
          ["N", "Z"],
          ["D", "C", "M"],
          ["P"]
        ]
      }

      expected_movements = [
        {1, 2, 1},
        {3, 1, 3},
        {2, 2, 1},
        {1, 1, 2}
      ]

      assert {expected_layout, expected_movements} == @test_input |> Day05.parse_input()
    end

    test "Part1" do
      assert "CMZ" == @test_input |> Part1.solve()
    end

    test "Part2" do
      assert "MCD" == @test_input |> Part2.solve()
    end
  end
end
