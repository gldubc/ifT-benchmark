input_file =
  case System.argv() do
    [path] ->
      path

    _ ->
      IO.puts(:stderr, "usage: elixir checker.exs <path-to-test-file>")
      System.halt(2)
  end

root = __DIR__
lib_dir = Path.join(root, "lib")
bench_file = Path.join(lib_dir, "benchmark_case.ex")

mix_env =
  case System.find_executable("elixir") do
    nil ->
      []

    elixir ->
      lib = Path.expand(Path.join([Path.dirname(elixir), "..", "lib"]))

      if File.dir?(Path.join(lib, "elixir/ebin")) and File.dir?(Path.join(lib, "mix/ebin")) do
        erl_libs =
          case System.get_env("ERL_LIBS") do
            nil -> lib
            "" -> lib
            existing -> lib <> ":" <> existing
          end

        [{"ERL_LIBS", erl_libs}]
      else
        []
      end
  end

File.mkdir_p!(lib_dir)
File.cp!(input_file, bench_file)

{_output, status} =
  System.cmd("mix", ["compile", "--warnings-as-errors", "--force"],
    cd: root,
    env: mix_env,
    stderr_to_stdout: true
  )

System.halt(status)
