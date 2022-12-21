defmodule Aoc2022.Day10 do
  alias Aoc2022.Day10

  defmodule Part1 do
    def solve(input) do
      input
        |> Day10.cycle_signals()
        |> Enum.with_index()
        |> Enum.drop(19)
        |> Enum.take_every(40)
        |> Enum.reduce(0, fn ({x, idx}, sum) ->
          sum + x * (idx + 1 )
        end)
    end
  end

  defmodule Part2 do
    def solve(input) do
      output =
        input
        |> Day10.cycle_signals()
        |> Enum.chunk_every(40)
        |> Enum.map(fn line ->
          line
          |> Enum.with_index()
          |> Enum.map(fn {x, idx} -> if abs(x - idx) < 2, do: "#", else: "." end)
          |> Enum.join()
        end)
        |> Enum.join("\n")

      output
    end
  end

  def cycle_signals(input) do
    input
    |> Aoc2022.read_lines()
    |> Aoc2022.remove_blanks()
    |> Enum.flat_map(&Day10.parse_command/1)
    |> Enum.reduce([1], fn (dx, [x | rest]) ->
      [x + dx, x | rest]
    end)
    |> Enum.reverse()
  end

  def parse_command("noop"), do: [0]
  def parse_command("addx " <> d), do: [0, String.to_integer(d)]
end
