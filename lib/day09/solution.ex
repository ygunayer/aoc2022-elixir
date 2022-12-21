defmodule Aoc2022.Day09 do
  alias Aoc2022.Day09

  defmodule State do
    defstruct [:snake, :seen]

    def new(length), do: %__MODULE__{snake: {0, 0} |> List.duplicate(length), seen: MapSet.new()}

    def move(%__MODULE__{} = self, {dx, dy}) do
      new_snake = Day09.move_snake(self.snake, {dx, dy})
      new_seen = self.seen |> MapSet.put(List.last(new_snake))
      %{self | snake: new_snake, seen: new_seen}
    end

  end

  defmodule Part1 do
    def solve(input), do: input |> Day09.solve_for(2)
  end

  defmodule Part2 do
    def solve(input), do: input |> Day09.solve_for(10)
  end

  def solve_for(input, length) do
    result =
      input
      |> Aoc2022.read_lines()
      |> Aoc2022.remove_blanks()
      |> Enum.flat_map(&parse_movement/1)
      |> Enum.reduce(State.new(length), &State.move(&2, &1))
    result.seen |> MapSet.size()
  end

  def move_snake([{x, y} | tail], {dx, dy}) do
    new_head = {x + dx, y + dy}
    [new_head | tail] |> move_tail()
  end

  def move_tail([last]), do: [last]

  def move_tail([head, tip | rest]) do
    new_tip = if is_close_enough?(tip, head), do: tip, else: tip |> move_towards(head)
    new_tail = [new_tip | rest] |> move_tail()
    [head | new_tail]
  end

  def is_close_enough?({x1, y1}, {x2, y2}), do: abs(x2 - x1) < 2 && abs(y2 - y1) < 2

  def move_towards({x1, y1}, {x2, y2}), do: {x1 + sign(x2 - x1), y1 + sign(y2 - y1)}

  def parse_movement("U " <> d), do: {0, -1} |> repeat(d)
  def parse_movement("R " <> d), do: {1, 0} |> repeat(d)
  def parse_movement("D " <> d), do: {0, 1} |> repeat(d)
  def parse_movement("L " <> d), do: {-1, 0} |> repeat(d)

  def repeat(item, count) when is_binary(count), do: repeat(item, String.to_integer(count))
  def repeat(item, count) when is_integer(count), do: (1..count) |> Enum.map(fn _ -> item end)

  def sign(n) when n == 0, do: 0
  def sign(n) when n > 0, do: 1
  def sign(n) when n < 0, do: -1
end
