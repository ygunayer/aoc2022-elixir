defmodule Aoc2022.Day05 do
  alias Aoc2022.Day05

  defmodule Part1 do
    def solve(input) do
      Day05.parse_input(input)
    end
  end

  def parse_input(input) do
    lines = input |> Aoc2022.read_lines()

    header =
      lines
      |> Enum.take_while(&Aoc2022.is_non_blank?/1)

    body =
      lines
      |> Enum.drop(header |> Enum.count())
      |> Enum.filter(&Aoc2022.is_non_blank?/1)

    IO.puts inspect([
      header |> Enum.drop(-1),
      body
    ])
  end
end
