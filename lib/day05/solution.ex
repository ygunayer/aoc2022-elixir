defmodule Aoc2022.Day05 do
  alias Aoc2022.Day05

  defmodule State do
    defstruct [:columns]

    def new(columns), do: %__MODULE__{columns: columns}

    def move(%__MODULE__{columns: columns}, {n, from, to}, retain_order \\ false) do
      source_column = columns |> Enum.at(from - 1)
      target_column = columns |> Enum.at(to - 1)

      {items_removed, new_source_column} = source_column |> Enum.split(n)

      items_to_move = case retain_order do
        true -> items_removed
        false -> items_removed |> Enum.reverse()
      end

      new_target_column = items_to_move ++ target_column

      new_columns =
        columns
        |> List.update_at(from - 1, fn _ -> new_source_column end)
        |> List.update_at(to - 1, fn _ -> new_target_column end)

      %__MODULE__{columns: new_columns}
    end

    def top(%__MODULE__{columns: columns}) do
      columns
      |> Enum.map(fn col ->
        case col |> Enum.at(0) do
          nil -> " "
          crate -> crate
        end
      end)
      |> Enum.join("")
    end
  end

  defmodule Part1 do
    def solve(input) do
      {state, movements} = Day05.parse_input(input)
      movements
      |> Enum.reduce(state, &State.move(&2, &1))
      |> State.top()
    end
  end

  defmodule Part2 do
    def solve(input) do
      {state, movements} = Day05.parse_input(input)
      movements
      |> Enum.reduce(state, &State.move(&2, &1, true))
      |> State.top()
    end
  end

  def parse_input(input) do
    lines = input |> Aoc2022.read_lines(false)

    header =
      lines
      |> Enum.take_while(&Aoc2022.is_non_blank?/1)

    layout =
      header
      |> Enum.reverse()
      |> parse_layout()

    movements =
      lines
      |> Enum.drop(header |> Enum.count())
      |> Enum.filter(&Aoc2022.is_non_blank?/1)
      |> Enum.map(&parse_movement/1)

    {layout, movements}
  end

  def parse_layout([counts_line | lines]) do
    num_crates = counts_line |> parse_num_crates()

    rows =
      lines
      |> Enum.map(&parse_layout_line(&1, num_crates))
      |> Enum.reverse()

    columns =
      rows
      |> Enum.zip()
      |> Enum.map(&Tuple.to_list/1)
      |> Enum.map(&Enum.filter(&1, fn x -> x != nil end))

    columns |> State.new()
  end

  def parse_num_crates(line) do
    [_, snum] = Regex.run(~r/(\d+)\s*$/, line)
    snum |> Aoc2022.parse_int!()
  end

  def parse_layout_line(line, num_crates) do
    padded_line =
      line
      |> String.pad_trailing(num_crates * 4 - 1, " ")

    Regex.scan(~r/(\[(\w+)\]|\s{3})\s?/, padded_line)
    |> Enum.reduce([], fn (match, acc) ->
      case match do
        [_, _, crate] -> [crate | acc]
        _ -> [nil | acc]
      end
    end)
    |> Enum.reverse()
  end

  def parse_movement(line) do
    [_, snum, sfrom, sto] = Regex.run(~r/(\d+).*(\d+).*(\d+)/, line)
    [snum, sfrom, sto]
    |> Enum.map(&Aoc2022.parse_int!/1)
    |> List.to_tuple()
  end
end
