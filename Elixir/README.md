Elixir
===

Elixir is a dynamic language that compiles to BEAM.

* Language resources:
  - <https://elixir-lang.org/>
  - <https://hexdocs.pm/elixir/Kernel.SpecialForms.html>
* If-T version: **1.0**
* Implementation: [./main.ex](./main.ex)
* Raw command to run the benchmark: `mix compile --warnings-as-errors --force` (through [./checker.exs](./checker.exs), which makes Mix load from the selected Elixir checkout)
* Driver commands from the repository root: `racket main.rkt elixir` and `racket main.rkt --examples elixir`
* Reported compiler: `/Users/gldubc/Code/research/elixir/main/bin/elixir`, commit `e17cb856a0af0ea327c8bf57c1de83219f4e559e` (`Elixir 1.21.0-dev`)

#### Type System Basics

> Q. What is the top type in this language? What is the bottom type? What is the dynamic type?
> If these types do not exist, explain the alternatives.

* Top = `term()`
* Bottom = `none()`
* Dynamic = Elixir is dynamically typed


> Q. What base types does this implementation use? Why?

`integer`, `binary` (string), and `boolean`.

They are the most direct analogs to the benchmark pseudocode.


> Q. What container types does this implementation use (for objects, tuples, etc)? Why?

* Maps for object-like values
* Tuples for fixed-size tuples
* Lists for list-like examples


#### Type Narrowing

> Q. How do simple type tests work in this language?

Runtime predicates such as `is_integer/1`, `is_binary/1`, and `is_map/1`.


> Q. Are there other forms of type test? If so, explain.

Pattern matching and guards in function heads and conditionals.


> Q. How do type casts work in this language?

N/A. Elixir does not have static casts in the same sense as gradual typed languages.


> Q. What is the syntax for a symmetric (2-way) type-narrowing predicate?

N/A. There is no built-in predicate annotation syntax like `x is T`.


> Q. If the language supports other type-narrowing predicates, describe them below.

N/A.


#### Benchmark Details

> Q. Are any benchmarks inexpressible? Why?

The benchmark scenarios are expressible as code. Some faithful negative cases emit type warnings with the research Elixir compiler, and the benchmark treats those warnings as failures via `--warnings-as-errors`.


> Q. Are any benchmarks expressed particularly well, or particularly poorly? Explain.

Container and guard-heavy cases are direct as Elixir programs. Predicate-annotation-specific cases are only approximated because Elixir has ordinary boolean predicates rather than typed predicate annotations.

The `connectives` disjunction failure uses `String.length(x) + x` instead of `x + 1`. Guard refinements in Elixir produce dynamic unions, so `x + 1` is compatible with `dynamic(binary() or integer())` through the integer alternative; the replacement keeps the string/number vocabulary while requiring the disjunctively refined value to be used inconsistently.

The `alias` benchmark bounds the input with a guard before assigning `y = is_binary(x)`. A direct `if is_binary(x)` refines `x` enough to reject `x + 1`, but using the saved boolean `y` does not refine `x`, so the failure case still compiles.


> Q. How direct (or complex) is the implementation compared to the pseudocode from If-T?

Moderately direct, with adaptations to Elixir idioms.


#### Advanced Examples

> Q. Are any examples inexpressible? Why?

No, but the faithful negative examples currently compile without type warnings.


> Q. Are any examples expressed particularly well, or particularly poorly? Explain.

`flatten` and `rainfall` map directly to recursive/iterative Elixir style.


> Q. How direct (or complex) is the implementation compared to the pseudocode from If-T?

Direct.
