defmodule Aoc2022.Day03Test do
  use ExUnit.Case

  alias Aoc2022.Day03
  alias Aoc2022.Day03.Part1
  alias Aoc2022.Day03.Part2

  @test_input File.read!("test/day03/input.txt")

  describe "Day03" do
    test "intersect/1" do
      input = [
        ["a", "b", "c"],
        ["b", "b", "x"],
        ["z", "b"]
      ]
      assert ["b"] == Day03.intersect(input)
    end

    test "score(list)" do
      assert 21 == Day03.score(["foobar", "bazbar"])
    end

    test "Part1" do
      assert 157 == @test_input |> Part1.solve()
    end

    test "Part2" do
      assert 70 == @test_input |> Part2.solve()
    end
  end
end
