defmodule Aoc2022.Day08 do
  alias Aoc2022.Day08

  defmodule Part1 do
    def solve(input) do
      {land, width, height} = Day08.analyze(input)

      visible_on_edges = (height + width) * 2 - 4

      visible_inside =
        (1..height - 2)
        |> Enum.flat_map(fn y -> (1..width - 2) |> Enum.map(&{&1, y}) end)
        |> Enum.count(&Day08.is_visible?(land, &1))

      visible_on_edges + visible_inside
    end
  end

  defmodule Part2 do
    def solve(input) do
      {land, width, height} = Day08.analyze(input)

      (1..height - 2)
      |> Enum.flat_map(fn y -> (1..width - 2) |> Enum.map(&{&1, y}) end)
      |> Enum.reduce(0, fn ({x, y}, acc) ->
        score = Day08.visibility_score(land, {x, y})
        max(score, acc)
      end)
    end
  end

  def is_visible?(land, {x, y}) do
    {n, directions} = get_view(land, x, y)
    directions
    |> Enum.any?(fn trees ->
      trees |> Enum.all?(&(&1 < n))
    end)
  end

  def visibility_score(land, {x, y}) do
    {n, directions} = get_view(land, x, y)
    directions
    |> Enum.map(&count_visible(&1, n))
    |> Enum.product()
  end

  def count_visible(trees, n) do
    {_, count} =
      trees
      |> Enum.reduce({false, 0}, fn (x, {done, count}) ->
        case done do
          true -> {true, count}
          _ -> {x >= n, count + 1}
        end
      end)
    count
  end

  def get_view(land, x, y) do
    n = land |> Enum.at(y) |> Enum.at(x)
    row = land |> Enum.at(y)
    col = land |> Enum.map(&(Enum.at(&1, x)))

    {left, [_ | right]} = row |> Enum.split(x)
    {up, [_ | down]} = col |> Enum.split(y)
    {n, [up |> Enum.reverse(), right, down, left |> Enum.reverse()]}
  end

  def analyze(input) do
    land = input |> Day08.parse_land()

    height = land |> Enum.count()
    width = land |> Enum.at(0) |> Enum.count()

    {land, width, height}
  end

  def parse_land(input) do
    input
    |> Aoc2022.read_lines()
    |> Aoc2022.remove_blanks()
    |> Enum.map(fn line -> line |> String.graphemes() |> Enum.map(&String.to_integer/1) end)
  end
end
