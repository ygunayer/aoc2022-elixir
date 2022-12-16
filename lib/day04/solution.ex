defmodule Aoc2022.Day04 do
  defmodule Part1 do
    alias Aoc2022.Day04

    def solve(input) do
      input
      |> Aoc2022.read_lines()
      |> Aoc2022.remove_blanks()
      |> Enum.map(&Day04.parse_line!/1)
      |> Enum.filter(&Day04.fully_overlaps?/1)
      |> Enum.count()
    end
  end

  defmodule Part2 do
    alias Aoc2022.Day04

    def solve(input) do
      input
      |> Aoc2022.read_lines()
      |> Aoc2022.remove_blanks()
      |> Enum.map(&Day04.parse_line!/1)
      |> Enum.filter(&Day04.overlaps?/1)
      |> Enum.count()
    end
  end

  def fully_overlaps?([a, b, c, d]) when (a <= c and b >= d) or (a >= c and b <= d), do: true
  def fully_overlaps?([a, b, c, d]) when a > b or c > d, do: raise "UNORDERED #{a}-#{b} (#{a > b}) , #{c}-#{d} (#{c > d})"
  def fully_overlaps?(_), do: false

  def overlaps?([a, b, c, d]), do: !Range.disjoint?(a..b, c..d)

  def parse_line!(line) do
    case Regex.run(~r/^(\d+)\-(\d+),(\d+)\-(\d+)$/, line) do
      [_, a, b, c, d] -> [a, b, c, d] |> Enum.map(&parse_int!/1)
      _ -> raise "Failed to parse line #{line}"
    end
  end

  def parse_int!(str) do
    case Integer.parse(str) do
      :error -> raise "Invalid number #{str}"
      {num, _} -> num
    end
  end
end
