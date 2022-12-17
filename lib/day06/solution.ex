defmodule Aoc2022.Day06 do
  alias Aoc2022.Day06

  defmodule Part1 do
    def solve(input) do
      input
      |> Aoc2022.read_lines()
      |> Enum.at(0)
      |> Day06.find_marker(4)
    end
  end

  defmodule Part2 do
    def solve(input) do
      input
      |> Aoc2022.read_lines()
      |> Enum.at(0)
      |> Day06.find_marker(14)
    end
  end

  def find_marker(input, chunk_size) do
    {_marker, chunk_idx} =
      input
      |> String.graphemes()
      |> Enum.chunk_every(chunk_size, 1)
      |> Enum.with_index()
      |> Enum.drop_while(fn {chars, _} -> non_unique?(chars) end)
      |> Enum.take(1)
      |> Enum.at(0)

    chunk_idx + chunk_size
  end

  def non_unique?(chars) do
    chars
    |> Enum.frequencies()
    |> Enum.any?(fn {_, v} -> v > 1 end)
  end
end
