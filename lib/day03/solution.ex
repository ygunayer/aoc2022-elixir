defmodule Aoc2022.Day03 do
  defmodule Part1 do
    alias Aoc2022.Day03

    def solve(input) do
      input
      |> Aoc2022.read_lines()
      |> Aoc2022.remove_blanks()
      |> Enum.map(&Day03.split_half/1)
      |> Enum.map(&Day03.score/1)
      |> Enum.sum()
    end
  end

  defmodule Part2 do
    alias Aoc2022.Day03

    def solve(input) do
      input
      |> Aoc2022.read_lines()
      |> Aoc2022.remove_blanks()
      |> Enum.chunk_every(3)
      |> Enum.map(&Day03.score/1)
      |> Enum.sum()
    end
  end

  def score(strings) when is_list(strings) do
    strings
    |> Enum.map(&String.graphemes/1)
    |> intersect()
    |> Enum.map(&score/1)
    |> Enum.sum()
  end
  def score(<<c>>) when c in ?a..?z, do: c - ?a + 1
  def score(<<c>>) when c in ?A..?Z, do: c - ?A + 27

  def intersect(list) do
    initial =
      Enum.at(list, 0)
      |> Enum.frequencies()

    list
    |> Enum.drop(1)
    |> Enum.reduce(initial, fn (items, map) ->
      common_keys =
        items
        |> Enum.filter(&Map.has_key?(map, &1))

      map |> Map.take(common_keys)
    end)
    |> Map.keys()
  end

  def split_half(line) do
    len =
      line
      |> String.length()
      |> div(2)

    [
      line |> String.slice(0, len),
      line |> String.slice(len, len)
    ]
  end
end
