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

File.mkdir_p!(lib_dir)
File.cp!(input_file, bench_file)

{_output, status} =
  System.cmd("mix", ["compile", "--warnings-as-errors", "--force"],
    cd: root,
    stderr_to_stdout: true
  )

System.halt(status)
