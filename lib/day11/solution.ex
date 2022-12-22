defmodule Aoc2022.Day11 do
  alias Aoc2022.Day11

  defmodule Part1 do
    def solve(), do: File.read!("lib/day11/input.txt") |> solve()
    def solve(input) do
      input
      |> Day11.parse_monkeys()
      |> Day11.run_monkeys(20)
      |> Day11.get_max_worries(2)
      |> Enum.product()
    end
  end

  defmodule Part2 do
    def solve(), do: File.read!("lib/day11/input.txt") |> solve()
    def solve(input) do
      input
      |> Day11.parse_monkeys()
      |> Day11.run_monkeys(10000, false)
      |> Day11.get_max_worries(2)
      |> Enum.product()
    end
  end

  def get_max_worries(worries, n \\ 2), do: worries |> Enum.reduce([], fn %{handled: handled}, acc -> (acc ++ [handled]) |> Enum.sort(:desc) |> Enum.take(n) end)

  def run_monkeys(monkeys, iterations, reduce_worries \\ true) do
    turns =
      monkeys
      |> Map.keys()
      |> List.duplicate(iterations)
      |> List.flatten()

    lcm = monkeys |> Map.values() |> Enum.map(&Map.get(&1, :divisible_by)) |> Enum.product()

    turns
    |> Enum.reduce(monkeys, fn id, curr_monkeys ->
      monkey = curr_monkeys |> Map.get(id)

      {true_items, false_items} = monkey |> run_monkey(reduce_worries, lcm)
      #IO.puts "#{id} --> #{inspect true_items, charlists: :as_lists} AND #{inspect false_items, charlists: :as_lists}"

      curr_monkeys
      |> Map.put(id, %{monkey | queue: [], handled: monkey.handled + length(monkey.queue)})
      |> update_in([monkey.true_target, :queue], fn items -> true_items ++ items end)
      |> update_in([monkey.false_target, :queue], fn items -> false_items ++ items end)
    end)
    |> Map.values()
  end

  def run_monkey(%{queue: queue, op: {op, arg}, divisible_by: divisible_by}, reduce_worries, lcm) do
    queue
    |> Enum.reduce({[], []}, fn old, {when_true, when_false} ->
      new_level = eval(old, op, arg)
      new_level = if reduce_worries, do: new_level |> div(3), else: new_level
      new_level = rem(new_level, lcm)
      case new_level |> is_divisible_by(divisible_by) do
        true -> {[new_level | when_true], when_false}
        false -> {when_true, [new_level | when_false]}
      end
    end)
  end

  def parse_monkeys(input) do
    input
    |> String.split("\n\n")
    |> Enum.map(&parse_monkey(&1))
    |> Map.new()
  end

  def parse_monkey(monkey_spec) do
    %{
      id: id,
      starting_items: starting_items,
      divisible_by: divisible_by,
      iftrue: true_target,
      iffalse: false_target,
      op: {op, arg}
    } = monkey_spec
      |> String.split("\n")
      |> Enum.map(&String.trim/1)
      |> Aoc2022.remove_blanks()
      |> Enum.map(&parse_line/1)
      |> Map.new()

    {
      id,
      %{
        id: id,
        queue: starting_items,
        handled: 0,
        divisible_by: divisible_by,
        op: {op, arg},
        true_target: true_target,
        false_target: false_target
      }
    }
  end

  def parse_line("Monkey " <> s) do
    [_, n] = Regex.run(~r/(\d+)/, s)
    {:id, String.to_integer(n)}
  end

  def parse_line("Starting items: " <> items) do
    starting_items =
      Regex.scan(~r/\d+/, items)
      |> Enum.flat_map(&(&1))
      |> Enum.map(&String.trim/1)
      |> Enum.map(&Aoc2022.parse_int!/1)
    {:starting_items, starting_items}
  end

  def parse_line("Operation: new = old " <> expr) do
    [_, op, arg] = Regex.run(~r/([\-\/\*\+])\s+([\w\d]+)/, expr)
    {:op, {op |> parse_op(), arg |> parse_arg()}}
  end

  def parse_line("Test: divisible by " <> n), do: {:divisible_by, String.to_integer(n)}

  def parse_line("If true: throw to monkey " <> n), do: {:iftrue, String.to_integer(n)}
  def parse_line("If false: throw to monkey " <> n), do: {:iffalse, String.to_integer(n)}

  def parse_op("*"), do: :mult
  def parse_op("+"), do: :add
  def parse_op("-"), do: :sub
  def parse_op("/"), do: :div

  def parse_arg("old"), do: :old
  def parse_arg(n), do: String.to_integer(n)

  def eval(a, op, :old), do: eval(a, op, a)

  def eval(a, :mult, b), do: a * b
  def eval(a, :add, b), do: a + b
  def eval(a, :sub, b), do: a - b
  def eval(a, :div, b), do: div(a, b)

  def is_divisible_by(x, y), do: rem(x, y) == 0
end
