defmodule Aoc2022.Day09Test do
  use ExUnit.Case

  alias Aoc2022.Day09
  alias Aoc2022.Day09.Part1
  alias Aoc2022.Day09.Part2

  @test_input File.read!("test/day09/input.txt")
  @test_input2 File.read!("test/day09/input2.txt")

  describe "Day09" do
    test "Part1" do
      assert 13 == @test_input |> Part1.solve()
    end

    test "Part2" do
      assert 36 == @test_input2 |> Part2.solve()
    end
  end
end
