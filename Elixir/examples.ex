defmodule IfTBenchmarkElixir.ExampleHelpers do
  def is_integer_predicate(x), do: is_integer(x)

  def tree_node?({value, children}) when is_integer(value) and is_list(children) do
    Enum.all?(children, &tree_node?/1)
  end

  def tree_node?(_), do: false
end

### Code:
## Example filter
## success
defmodule IfTBenchmarkElixir.FilterSuccess do
  def run(list, predicate) do
    Enum.reduce(list, [], fn element, acc ->
      if predicate.(element) do
        [element | acc]
      else
        acc
      end
    end)
  end
end

## failure
defmodule IfTBenchmarkElixir.FilterFailure do
  def run(list, predicate) do
    Enum.reduce(list, [], fn element, acc ->
      if predicate.(element) do
        [element | acc]
      else
        [element | acc]
      end
    end)
  end
end

## Example flatten
## success
defmodule IfTBenchmarkElixir.FlattenSuccess do
  def run([]), do: []
  def run([head | tail]), do: run(head) ++ run(tail)
  def run(value), do: [value]
end

## failure
defmodule IfTBenchmarkElixir.FlattenFailure do
  def run([]), do: []
  def run([head | tail]), do: run(head) ++ run(tail)
  def run(value), do: value
end

## Example tree_node
## success
defmodule IfTBenchmarkElixir.TreeNodeSuccess do
  def run(node), do: IfTBenchmarkElixir.ExampleHelpers.tree_node?(node)
end

## failure
defmodule IfTBenchmarkElixir.TreeNodeFailure do
  def tree_node?({value, children}) when is_integer(value) and is_list(children) do
    true
  end

  def tree_node?(_), do: false
end

## Example rainfall
## success
defmodule IfTBenchmarkElixir.RainfallSuccess do
  def run(weather_reports) when is_list(weather_reports) do
    {total, count} =
      Enum.reduce(weather_reports, {0.0, 0}, fn day, {total, count} ->
        if is_map(day) and Map.has_key?(day, :rainfall) do
          value = Map.get(day, :rainfall)

          if is_number(value) and value >= 0 and value <= 999 do
            {total + value, count + 1}
          else
            {total, count}
          end
        else
          {total, count}
        end
      end)

    if count > 0 do
      total / count
    else
      0
    end
  end
end

## failure
defmodule IfTBenchmarkElixir.RainfallFailure do
  def run(weather_reports) when is_list(weather_reports) do
    Enum.reduce(weather_reports, 0.0, fn day, total ->
      if is_map(day) and Map.has_key?(day, :rainfall) do
        value = Map.get(day, :rainfall)
        total + value
      else
        total
      end
    end)
  end
end
