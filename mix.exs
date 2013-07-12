defmodule Algorithms.Mixfile do
  use Mix.Project

  def project do
    [ app: :algorithms,
      version: "0.0.2",
      elixir: "~> 0.9.4-dev",
      source_url: "https://github.com/valmet/algorithms",

      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    []
  end

  # Returns the list of dependencies in the format:
  # { :foobar, "0.1", git: "https://github.com/elixir-lang/foobar.git" }
  defp deps do
    [
    #  { :benchmark, git: "https://github.com/meh/elixir-benchmark.git" },
    #  { :ex_doc, github: "elixir-lang/ex_doc" },
    ]
  end
end
