defmodule InutileDB do
  @moduledoc """
  This is the main entrypoint for the InutileDB app.

  Starts a server based on the command line options
  e.g. a directory server listening on a given port.
  """

  use Application

  def start(_type, _args) do
    options = get_options()

    server_module = determine_mode(
      String.to_existing_atom(options[:node_mode])
    )

    GenServer.start_link(server_module, %{
      port: options[:listen_port]
    })
  end

  defp determine_mode(mode_atom) do
    mode_map = %{
      directory: InutileDB.Modes.Directory.Server,
      echo:  InutileDB.Modes.Echo.Server,
      data: "hello!"
    }

    server_module = mode_map[mode_atom]

    if (server_module === nil) do
      raise KeyError, message: "Unable to determine server for specified mode"
    end

    server_module
  end

  defp get_options() do
    { options, _, _ } = OptionParser.parse(
      System.argv(),

      switches: [
        listen_port: :integer,
        node_mode: :string,
      ],

      aliases: [
        p: :listen_port,
        m: :node_mode,
      ]
    )

    IO.inspect(options)

    options
  end
end
