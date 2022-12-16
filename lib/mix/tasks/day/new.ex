defmodule Mix.Tasks.Day.New do
  def run([day]) do
    padded_day = day |> to_string() |> String.pad_leading(2, "0")

    root_lib_dir = Path.join(["lib", "day" <> padded_day])
    root_test_dir = Path.join(["test", "day" <> padded_day])

    root_lib_dir |> mkdir()
    Path.join([root_lib_dir, "solution.ex"]) |> File.write!(render_solution_file(padded_day))
    Path.join([root_lib_dir, "input.txt"]) |> File.write!("")

    root_test_dir |> mkdir()
    Path.join([root_test_dir, "solution_test.exs"]) |> File.write!(render_test_file(padded_day))
  end

  defp mkdir(path) do
    unless File.exists?(path) do
      File.mkdir!(path)
    end
  end

  defp render_solution_file(day) do
    """
    defmodule Aoc2022.Day#{day} do
      defmodule State do
        defstruct []

        def new, do: %__MODULE__{}
      end

      defmodule Part1 do
        def solve(input) do
          raise "Not implemented yet"
        end
      end
    end
    """
  end

  defp render_test_file(day) do
    """
    defmodule Aoc2022.Day#{day}Test do
      use ExUnit.Case

      alias Aoc2022.Day#{day}.Part1

      @test_input1 \"\"\"
      \"\"\"

      describe "Day#{day}" do
        test "Part1" do
          assert 42 == @test_input1 |> Part1.solve()
        end
      end
    end
    """
  end
end
