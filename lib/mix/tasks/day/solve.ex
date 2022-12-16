defmodule Mix.Tasks.Day.Solve do
  use Mix.Task

  def run(args) do
    [day, part] = case args do
      [day] -> [day, "1"]
      [_, _] -> args
    end

    padded_day = day |> to_string() |> String.pad_leading(2, "0")

    input = read_input!(padded_day, part)

    result = Module.concat([
      Aoc2022,
      "Day#{padded_day}",
      "Part#{part}"
    ])
    |> apply(:solve, [input])

    IO.puts result
  end

  def read_input!(day, part) do
    day_dir = Path.join("lib", "day" <> day)

    part_file = Path.join(day_dir, "input" <> part <> ".txt")
    common_file = Path.join(day_dir, "input.txt")

    [part_file, common_file]
    |> Enum.filter(&File.exists?/1)
    |> Enum.at(0)
    |> File.read!()
  end
end
