defmodule Aoc2022.Day02 do
  defmodule Part1 do
    alias Aoc2022.Day02

    def solve(input) do
      input
      |> Day02.read_lines()
      |> Enum.reduce(0, fn ([left, right], acc) ->
        opponent = Day02.parse_move(left)
        me = Day02.parse_move(right)
        acc + Day02.score(me, opponent)
      end)
    end
  end

  defmodule Part2 do
    alias Aoc2022.Day02

    def solve(input) do
      input
      |> Day02.read_lines()
      |> Enum.reduce(0, fn ([left, right], acc) ->
        opponent = Day02.parse_move(left)
        intent = Day02.parse_intent(right)
        me = Day02.match_reverse(opponent, intent)
        acc + Day02.score(me, opponent)
      end)
    end
  end

  def score(me, opponent), do: move_score(me) + (match(me, opponent) |> match_score())

  def match(:paper, :rock), do: :win
  def match(:rock, :scissors), do: :win
  def match(:scissors, :paper), do: :win
  def match(x, y) when x == y, do: :draw
  def match(_, _), do: :lose

  def match_reverse(:paper, :win), do: :scissors
  def match_reverse(:paper, :lose), do: :rock
  def match_reverse(:rock, :win), do: :paper
  def match_reverse(:rock, :lose), do: :scissors
  def match_reverse(:scissors, :win), do: :rock
  def match_reverse(:scissors, :lose), do: :paper
  def match_reverse(x, :draw), do: x

  def move_score(:rock), do: 1
  def move_score(:paper), do: 2
  def move_score(:scissors), do: 3

  def match_score(:win), do: 6
  def match_score(:draw), do: 3
  def match_score(:lose), do: 0

  def read_lines(input) do
    input
    |> Aoc2022.read_lines()
    |> Enum.filter(&is_non_blank?(&1))
    |> Enum.map(fn line ->
      [left, right] =
        line
        |> String.trim()
        |> String.split(~r/\s+/)
      [left, right]
    end)
  end

  def parse_move("A"), do: :rock
  def parse_move("B"), do: :paper
  def parse_move("C"), do: :scissors
  def parse_move("X"), do: :rock
  def parse_move("Y"), do: :paper
  def parse_move("Z"), do: :scissors

  def parse_intent("X"), do: :lose
  def parse_intent("Y"), do: :draw
  def parse_intent("Z"), do: :win

  def is_non_blank?(""), do: false
  def is_non_blank?(x) when is_binary(x), do: true
end
