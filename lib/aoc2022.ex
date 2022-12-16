defmodule Aoc2022 do
  def read_lines(input) do
    input
    |> String.split(~r/\n/)
    |> Enum.map(&String.trim/1)
  end

  def remove_blanks(lines), do: lines |> Enum.filter(&is_non_blank?/1)

  def is_non_blank?(""), do: false
  def is_non_blank?(x) when is_binary(x), do: true
end
