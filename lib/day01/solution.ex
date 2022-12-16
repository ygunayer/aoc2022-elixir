defmodule Aoc2022.Day01 do
  defmodule State do
    @max_totals_limit 3

    defstruct [:max_totals, :running_total]

    def new, do: %__MODULE__{max_totals: [], running_total: 0}

    def add(%__MODULE__{} = self, num), do: %__MODULE__{max_totals: self.max_totals, running_total: self.running_total + num}

    def end_loop(%__MODULE__{max_totals: max_totals, running_total: running_total}) do
      new_max_totals = max_totals ++ [running_total]
      |> Enum.sort(:desc)
      |> Enum.take(@max_totals_limit)

      %__MODULE__{
        max_totals: new_max_totals,
        running_total: 0
      }
    end

    def acc("", {:ok, %__MODULE__{} = self}), do: {:ok, self |> end_loop()}
    def acc(str, {:ok, %__MODULE__{} = self}) when is_binary(str) do
      case str |> Integer.parse() do
        :error -> {:error, :parse_failed, str}
        {num, _} -> {:ok, self |> add(num)}
      end
    end
    def acc(_, other), do: other
  end

  defmodule Part1 do
    def solve(input) do
      {:ok, result} = input
      |> Aoc2022.read_lines()
      |> Enum.reduce({:ok, State.new}, &State.acc(&1, &2))

      final_result = result |> State.end_loop()
      final_result.max_totals |> Enum.at(0)
    end
  end

  defmodule Part2 do
    def solve(input) do
      {:ok, result} = input
      |> Aoc2022.read_lines()
      |> Enum.reduce({:ok, State.new}, &State.acc(&1, &2))

      final_result = result |> State.end_loop()
      final_result.max_totals |> Enum.sum()
    end
  end

end
