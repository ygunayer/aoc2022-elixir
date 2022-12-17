defmodule Aoc2022.Day04Test do
  use ExUnit.Case

  alias Aoc2022.Day04
  alias Aoc2022.Day04.Part1
  alias Aoc2022.Day04.Part2

  @test_input File.read!("test/day04/input.txt")

  describe "Day04.fully_contains?" do
    cases = [
      {[1, 2, 3, 4], false}, # ++--- --++-
      {[1, 3, 3, 4], false}, # +++-- --++-
      {[4, 5, 3, 4], false}, # ---++ --++-
      {[1, 3, 2, 5], false}, # +++-- -++++
      {[2, 4, 3, 5], false}, # -+++- --+++

      {[1, 4, 3, 4], true},  # ++++- -+++-
      {[2, 4, 1, 5], true},  # -+++- +++++
      {[2, 4, 2, 4], true},  # -+++- -+++-
      {[2, 4, 2, 5], true},  # -+++- -++++
      {[1, 5, 3, 3], true},  # +++++ --+--
    ]

    for {range, expected} <- cases do
      test "fully_overlaps?(#{inspect range}) == #{expected}" do
        assert unquote(expected) == Day04.fully_overlaps?(unquote(range))
      end
    end
  end

  describe "Day04" do
    test "Part1" do
      assert 2 == @test_input |> Part1.solve()
    end

    test "Part2" do
      assert 4 == @test_input |> Part2.solve()
    end
  end
end
