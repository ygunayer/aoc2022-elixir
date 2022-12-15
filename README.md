# Advent of Code 2022
My Elixir solutions for Advent of Code 2022

## Running
Make sure to retrieve dependencies

```bash
$ mix deps.get
```

And then run the tests

```bash
$ mix test
```

You can also run a specific solution part and day by running the `day.run` mix task

```bash
# runs part 1 of day 1
$ mix day.solve 1

# runs part 4 of day 3
$ mix day.solve 3 4
```

## Development
You can generate a set of solution and test files for any given day by running the `day.new` task.

This creates a 1-part solution for the given day, so it's up to the developer to add more parts

```bash
# creates files for day 42
$ mix day.new 42
```

## License
MIT
