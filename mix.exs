defmodule MyProject.MixProject do
    use Mix.Project

    def project do
        [
            app: :inutiledb,
            version: "0.1.0",
            elixir: "~> 1.16",
            start_permanent: Mix.env() == :prod,
            deps: deps()
        ]
    end
      
    def application do
      [
        mod: { TCPServer, [] }
      ]
    end

    defp deps do
        [
        ]
    end
end
