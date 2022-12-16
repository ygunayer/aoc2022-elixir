defmodule Aoc2022.Day05Test do
  use ExUnit.Case

  alias Aoc2022.Day05
  alias Aoc2022.Day05.Part1

  @test_input1 """
  [D]
  [N] [C]
  [Z] [M] [P]
   1   2   3

  move 1 from 2 to 1
  move 3 from 1 to 3
  move 2 from 2 to 1
  move 1 from 1 to 2
  """

  describe "Day05" do
    test "Part1" do
      assert "CMZ" == @test_input1 |> Part1.solve()
    end
  end
end
