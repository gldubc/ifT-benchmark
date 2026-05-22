defmodule IfTBenchmarkElixir.Helpers do
  def positive_integer?(x), do: is_integer(x) and x > 0

  def binary_or_integer?(x), do: is_binary(x) or is_integer(x)

  def integer_value?(x) when is_integer(x), do: true
  def integer_value?(_), do: false
end

### Code:
## Example positive
## success
defmodule IfTBenchmarkElixir.PositiveSuccess do
  def f(x) do
    if is_binary(x) do
      String.length(x)
    else
      x
    end
  end
end

## failure
defmodule IfTBenchmarkElixir.PositiveFailure do
  def f(x) do
    if is_binary(x) do
      x + 1
    else
      x
    end
  end
end

## Example negative
## success
defmodule IfTBenchmarkElixir.NegativeSuccess do
  def f(x) when is_binary(x) or is_integer(x) do
    if is_binary(x) do
      String.length(x)
    else
      x + 1
    end
  end
end

## failure
defmodule IfTBenchmarkElixir.NegativeFailure do
  def f(x) when is_binary(x) or is_boolean(x) do
    if is_binary(x) do
      String.length(x)
    else
      x + 1
    end
  end
end

## Example connectives
## success
defmodule IfTBenchmarkElixir.ConnectivesSuccess do
  def f(x) when is_binary(x) or is_integer(x) do
    if not is_integer(x), do: String.length(x), else: 0
  end

  def g(x) do
    case x do
      x when is_binary(x) or is_integer(x) -> f(x)
      _ -> 0
    end
  end

  def h(x) when is_binary(x) or is_integer(x) or is_boolean(x) do
    if not is_boolean(x) and not is_integer(x), do: String.length(x), else: 0
  end
end

## failure
defmodule IfTBenchmarkElixir.ConnectivesFailure do
  def f(x) when is_binary(x) or is_integer(x) do
    if not is_integer(x), do: x + 1, else: 0
  end

  def g(x) do
    case x do
      x when is_binary(x) or is_integer(x) -> String.length(x) + x
      _ -> 0
    end
  end

  def h(x) when is_binary(x) or is_integer(x) or is_boolean(x) do
    if not is_boolean(x) and not is_integer(x), do: x + 1, else: 0
  end
end

## Example nesting_body
## success
defmodule IfTBenchmarkElixir.NestingBodySuccess do
  def f(x) do
    if not is_binary(x) do
      if not is_boolean(x) do
        x + 1
      else
        0
      end
    else
      0
    end
  end
end

## failure
defmodule IfTBenchmarkElixir.NestingBodyFailure do
  def f(x) do
    if not is_binary(x) do
      if not is_boolean(x) do
        String.length(x)
      else
        0
      end
    else
      x
    end
  end
end

## Example struct_fields
## success
defmodule IfTBenchmarkElixir.StructFieldsSuccess do
  def f(%{a: a}) do
    if is_integer(a) do
      a
    else
      0
    end
  end
end

## failure
defmodule IfTBenchmarkElixir.StructFieldsFailure do
  def f(%{a: a}) do
    if is_integer(a) do
      String.length(a)
    else
      0
    end
  end
end

## Example tuple_elements
## success
defmodule IfTBenchmarkElixir.TupleElementsSuccess do
  def f({a, _b}) do
    if is_integer(a) do
      a
    else
      0
    end
  end
end

## failure
defmodule IfTBenchmarkElixir.TupleElementsFailure do
  def f({a, _b}) do
    if is_integer(a) do
      String.length(a)
    else
      0
    end
  end
end

## Example tuple_length
## success
defmodule IfTBenchmarkElixir.TupleLengthSuccess do
  def f(x)
      when (tuple_size(x) == 2 and is_integer(elem(x, 0)) and is_integer(elem(x, 1))) or
             (tuple_size(x) == 3 and
                is_binary(elem(x, 0)) and
                is_binary(elem(x, 1)) and is_binary(elem(x, 2))) do
    if tuple_size(x) == 2 do
      elem(x, 0) + elem(x, 1)
    else
      elem(x, 0) <> elem(x, 1) <> elem(x, 2)
    end
  end
end

## failure
defmodule IfTBenchmarkElixir.TupleLengthFailure do
  def g(x)
      when (tuple_size(x) == 2 and is_integer(elem(x, 0)) and is_integer(elem(x, 1))) or
             (tuple_size(x) == 3 and
                is_binary(elem(x, 0)) and
                is_binary(elem(x, 1)) and is_binary(elem(x, 2))) do
    case x do
      {a, b} -> a + b
      {_, _, _} -> elem(x, 0) + elem(x, 1)
    end
  end
end

## Example alias
## success
defmodule IfTBenchmarkElixir.AliasSuccess do
  def f(x) when is_binary(x) or is_integer(x) do
    y = is_binary(x)

    if y do
      String.length(x)
    else
      x + 1
    end
  end
end

## failure
defmodule IfTBenchmarkElixir.AliasFailure do
  def f(x) when is_binary(x) or is_integer(x) do
    y = is_binary(x)

    if y do
      x + 1
    else
      x
    end
  end
end

## Example nesting_condition
## success
defmodule IfTBenchmarkElixir.NestingConditionSuccess do
  def f(x, y)
      when (is_integer(x) or is_binary(x)) and (is_binary(y) or is_integer(y)) do
    if if(is_integer(x), do: is_binary(y), else: false) do
      x + String.length(y)
    else
      0
    end
  end
end

## failure
defmodule IfTBenchmarkElixir.NestingConditionFailure do
  def f(x, y)
      when (is_integer(x) or is_binary(x)) and (is_binary(y) or is_integer(y)) do
    if if(is_integer(x), do: is_binary(y), else: is_binary(y)) do
      String.length(x) + x
    else
      0
    end
  end
end

## Example merge_with_union
## success
defmodule IfTBenchmarkElixir.MergeWithUnionSuccess do
  def f(x) do
    y =
      cond do
        is_binary(x) -> x <> "hello"
        is_integer(x) -> x + 1
        true -> 0
      end

    y
  end
end

## failure
defmodule IfTBenchmarkElixir.MergeWithUnionFailure do
  def f(x) do
    y =
      cond do
        is_binary(x) -> x <> "hello"
        is_integer(x) -> x + 1
        true -> 0
      end

    String.length(y) + y
  end
end

## Example predicate_2way
## success
defmodule IfTBenchmarkElixir.Predicate2WaySuccess do
  def binary_value?(x), do: is_binary(x)

  def g(x) do
    if binary_value?(x) do
      String.length(x)
    else
      x
    end
  end
end

## failure
defmodule IfTBenchmarkElixir.Predicate2WayFailure do
  def binary_value?(x), do: is_binary(x)

  def g(x) do
    if binary_value?(x) do
      x + 1
    else
      x
    end
  end
end

## Example predicate_1way
## success
defmodule IfTBenchmarkElixir.Predicate1WaySuccess do
  def g(x) do
    if IfTBenchmarkElixir.Helpers.positive_integer?(x) do
      x + 1
    else
      0
    end
  end
end

## failure
defmodule IfTBenchmarkElixir.Predicate1WayFailure do
  def g(x) do
    if IfTBenchmarkElixir.Helpers.positive_integer?(x) do
      x + 1
    else
      String.length(x)
    end
  end
end

## Example predicate_checked
## success
defmodule IfTBenchmarkElixir.PredicateCheckedSuccess do
  def g(x) do
    if IfTBenchmarkElixir.Helpers.integer_value?(x) do
      x + 1
    else
      0
    end
  end
end

## failure
defmodule IfTBenchmarkElixir.PredicateCheckedFailure do
  def checked_integer?(_x), do: true

  def g(x) do
    if checked_integer?(x) do
      x + 1
    else
      0
    end
  end
end
