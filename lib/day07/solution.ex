defmodule Aoc2022.Day07 do
  alias Aoc2022.Day07

  defmodule Part1 do
    @max_allowed_size 100000

    def solve(input) do
      input
      |> Day07.build_tree!()
      |> Day07.flatten_sizes()
      |> Map.values()
      |> Enum.filter(fn size -> size <= @max_allowed_size end)
      |> Enum.sum()
    end
  end

  defmodule Part2 do
    @min_unused_space 30000000
    @total_space 70000000

    def solve(input) do
      sizes =
        input
        |> Day07.build_tree!()
        |> Day07.flatten_sizes()

      used_space = sizes |> Map.get("")
      unused_space = @total_space - used_space
      required_space = @min_unused_space - unused_space

      sizes
      |> Map.values()
      |> Enum.filter(fn size -> size >= required_space end)
      |> Enum.min()
    end
  end

  def build_tree!(input) do
    {tree, _ } =
      input
      |> Aoc2022.read_lines()
      |> Enum.filter(&Aoc2022.is_non_blank?/1)
      |> Enum.reduce({%{}, []}, &cmd!(&2, &1))
    tree
  end

  def cmd!({tree, _}, "$ cd /"), do: {tree, []}
  def cmd!({tree, [_ | parent_path]}, "$ cd .."), do: {tree, parent_path}
  def cmd!({tree, path}, "$ cd " <> name), do: {tree, [name | path]}
  def cmd!({tree, path}, "$ ls"), do: {tree, path}
  def cmd!({tree, path}, "dir " <> name), do: {tree, path} |> put_item(name, %{})
  def cmd!({tree, path}, line) do
    case Regex.run(~r/(\d+)\s+([\w\d\.]+)/, line) do
      [_, size, name] -> {tree, path} |> put_item(name, String.to_integer(size))
      _ -> raise "Failed to parse command #{line}"
    end
  end

  def put_item({tree, path}, name, item), do: {put_in(tree, [name | path] |> Enum.reverse(), item), path}

  def flatten_sizes(tree) when is_map(tree) do
    {sizes, _} = flatten_sizes("", tree)
    sizes
  end

  defp flatten_sizes(_, leaf) when is_integer(leaf), do: {%{}, leaf}
  defp flatten_sizes(path, leaf) when is_map(leaf) do
    {children, my_size} =
      leaf
      |> Enum.reduce({%{}, 0}, fn ({k, v}, {acc, running_total}) ->
        {descendants, child_size} = flatten_sizes(path <> "/" <> k, v)
        {
          Map.merge(acc, descendants),
          child_size + running_total
        }
      end)
    {children |> Map.put(path, my_size), my_size}
  end

  def size_of(leaf) when is_integer(leaf), do: leaf
  def size_of(leaf) when is_map(leaf), do: leaf |> Map.values() |> Enum.map(&size_of/1) |> Enum.sum()
end
