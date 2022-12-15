defmodule Mix.Tasks.Day.Solve do
  use Mix.Task

  def run(args) do
    [day, part] = case args do
      [day] -> [day, "1"]
      [_, _] -> args
    end

    padded_day = day |> to_string() |> String.pad_leading(2, "0")

    input = Path.join([
      "lib",
      "day" <> padded_day,
      "input" <> part <> ".txt"
    ])
    |> File.read!()

    result = Module.concat([
      Aoc2022,
      "Day#{padded_day}",
      "Part#{part}"
    ])
    |> apply(:solve, [input])

    IO.puts result
  end
end
