defmodule Aoc2022.Day10Test do
  use ExUnit.Case

  alias Aoc2022.Day10
  alias Aoc2022.Day10.Part1
  alias Aoc2022.Day10.Part2

  @test_input File.read!("test/day10/input.txt")
  @test_output2 """
  ##..##..##..##..##..##..##..##..##..##..
  ###...###...###...###...###...###...###.
  ####....####....####....####....####....
  #####.....#####.....#####.....#####.....
  ######......######......######......####
  #######.......#######.......#######.....
  """

  describe "Day10" do
    test "Part1" do
      assert 13140 == @test_input |> Part1.solve()
    end

    test "Part2" do
      assert @test_output2 == @test_input |> Part2.solve() |> String.trim_trailing(".")
    end
  end
end
