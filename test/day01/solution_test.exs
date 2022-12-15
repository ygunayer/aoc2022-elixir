defmodule Aoc2022.Day01Test do
  use ExUnit.Case

  alias Aoc2022.Day01.Part1
  alias Aoc2022.Day01.Part2

  @test_input1 """
    1000
    2000
    3000

    4000

    5000
    6000

    7000
    8000
    9000

    10000
  """

  describe "Day01" do
    test "Part1" do
      assert 24000 == @test_input1 |> Part1.solve()
    end

    test "Part2" do
      assert 45000 == @test_input1 |> Part2.solve()
    end
  end
end
