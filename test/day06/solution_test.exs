defmodule Aoc2022.Day06Test do
  use ExUnit.Case

  alias Aoc2022.Day06.Part1
  alias Aoc2022.Day06.Part2

  @test_input File.read!("test/day06/input.txt") |> String.split("\n")

  describe "Day06" do
    part1_answers = [7, 5, 6, 10, 11]
    part2_answers = [19, 23, 23, 29, 26]

    for {line, answer} <- Enum.zip(@test_input, part1_answers) do
      test "Part1.solve for #{line} == #{answer}" do
        assert unquote(answer) == unquote(line) |> Part1.solve()
      end
    end

    for {line, answer} <- Enum.zip(@test_input, part2_answers) do
      test "Part2.solve for #{line} == #{answer}" do
        assert unquote(answer) == unquote(line) |> Part2.solve()
      end
    end
  end
end
