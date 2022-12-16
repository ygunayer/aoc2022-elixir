defmodule Mix.Tasks.Day.New do
  def run(args) do
    {padded_day, lib_dir, test_dir} = parse_args(args)
    {raw_day, _} = Integer.parse(padded_day)

    lib_dir |> mkdir()
    Path.join([lib_dir, "solution.ex"]) |> File.write!(render_solution_file(padded_day))
    Path.join([lib_dir, "input.txt"]) |> File.write!("")

    test_dir |> mkdir()
    Path.join([test_dir, "solution_test.exs"]) |> File.write!(render_test_file(padded_day))

    IO.puts "Generated files for day #{padded_day}"
    IO.puts "Instructions: https://adventofcode.com/2022/day/#{raw_day}"
    IO.puts "Input: https://adventofcode.com/2022/day/#{raw_day}/input"
  end

  def parse_args([]) do
    1..31
    |> Enum.map(&leftpad/1)
    |> Enum.map(&get_dirs/1)
    |> Enum.drop_while(fn {_, lib_dir, _} ->
      lib_dir |> File.exists?()
    end)
    |> Enum.take(1)
    |> Enum.at(0)
  end
  def parse_args([day]), do: get_dirs(day)

  defp get_dirs(day) do
    padded_day = day |> leftpad()
    {padded_day, lib_dir_for(day), test_dir_for(day)}
  end

  defp lib_dir_for(day), do: Path.join(["lib", "day" <> leftpad(day)])
  defp test_dir_for(day), do: Path.join(["test", "day" <> leftpad(day)])

  defp leftpad(input, len \\ 2), do: input |> to_string() |> String.pad_leading(len, "0")

  defp mkdir(path) do
    unless File.exists?(path) do
      File.mkdir!(path)
    end
  end

  defp render_solution_file(day) do
    """
    defmodule Aoc2022.Day#{day} do
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

      alias Aoc2022.Day#{day}
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
