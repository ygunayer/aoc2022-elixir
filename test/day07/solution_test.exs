defmodule Aoc2022.Day07Test do
  use ExUnit.Case

  alias Aoc2022.Day07
  alias Aoc2022.Day07.Part1
  alias Aoc2022.Day07.Part2

  @test_input File.read!("test/day07/input.txt")

  describe "Day07" do
    test "build_tree!" do
      expected = %{
        "a" => %{
          "e" => %{
            "i" => 584
          },
          "f" => 29116,
          "g" => 2557,
          "h.lst" => 62596
        },
        "b.txt" => 14848514,
        "c.dat" => 8504156,
        "d" => %{
          "j" => 4060174,
          "d.log" => 8033020,
          "d.ext" => 5626152,
          "k" => 7214296
        }
      }

      assert expected == @test_input |> Day07.build_tree!()
    end

    test "flatten_sizes" do
      expected = %{
        "" => 48381165,
        "/a/e" => 584,
        "/a" => 94853,
        "/d" => 24933642
      }

      assert expected == @test_input |> Day07.build_tree!() |> Day07.flatten_sizes()
    end

    test "Part1" do
      assert 95437 == @test_input |> Part1.solve()
    end

    test "Part2" do
      assert 24933642 == @test_input |> Part2.solve()
    end
  end
end
