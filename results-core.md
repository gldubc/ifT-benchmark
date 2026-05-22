| Benchmark         | Typed Racket | TypeScript | Flow | mypy | Pyright | Sorbet | Luau   | MLsem | Typed Clojure | ty     | Pyrefly | Elixir |
|:------------------|:------------:|:----------:|:----:|:----:|:-------:|:------:|:------:|:-----:|:-------------:|:------:|:-------:|:------:|
| positive          | O            | O          | O    | O    | O       | O      | O      | O     | O             | O      | O       | x      |
| negative          | O            | O          | O    | O    | O       | O      | O      | O     | O             | O      | O       | x      |
| connectives       | O            | O          | O    | O    | O       | O      | O      | x     | O             | O      | O       | x      |
| nesting_body      | O            | O          | O    | O    | O       | O      | O      | O     | O             | O      | O       | x      |
| struct_fields     | O            | O          | O    | O    | O       | x      | O      | O     | O             | O      | O       | x      |
| tuple_elements    | O            | O          | O    | O    | O       | O      | O      | O     | O             | O      | O       | x      |
| tuple_length      | x            | O          | O    | O    | O       | x      | x      | O     | O             | x      | O       | x      |
| alias             | O            | O          | x    | x    | O       | O      | x      | O     | O             | x      | O       | x      |
| nesting_condition | O            | x          | x    | x    | x       | O      | x      | O     | O             | x      | x       | x      |
| merge_with_union  | O            | O          | O    | x    | O       | O      | x      | O     | O             | O      | O       | x      |
| predicate_2way    | O            | O          | O    | O    | O       | x      | x      | O     | O             | O      | O       | x      |
| predicate_1way    | O            | x          | O    | O    | O       | x      | x      | O     | O             | O      | O       | x      |
| predicate_checked | O            | x          | O    | x    | x       | x      | x      | O     | O             | x      | x       | x      |
