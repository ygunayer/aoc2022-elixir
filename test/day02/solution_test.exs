defmodule Aoc2022.Day02Test do
  use ExUnit.Case

  alias Aoc2022.Day02.Part1
  alias Aoc2022.Day02.Part2

  @test_input File.read!("test/day02/input.txt")

  describe "Day02" do
    test "Part1" do
      assert 15 == @test_input |> Part1.solve()
    end

    test "Part2" do
      assert 12 == @test_input |> Part2.solve()
    end
  end
end
