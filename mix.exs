defmodule MyProject.MixProject do
  use Mix.Project

  def project do
    [
      app: :inutiledb,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: escript()
    ]
  end

  defp escript do
    [ main_module: InutileDB ]
  end

  def application do
    [
      mod: { InutileDB, [] }
    ]
  end

  defp deps do
    [
      { :yaml_elixir, "~> 2.9" },
      { :optimus, "~> 0.2" },
    ]
  end
end
