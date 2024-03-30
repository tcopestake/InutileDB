defmodule InutileDB do
  @moduledoc """
  This is the main entrypoint for the InutileDB app.

  Starts a server based on the command line options
  e.g. a directory worker listening on a given port.
  """

  use Application

  def start(_type, _args) do
    options = get_options()

    worker_module = determine_worker_module(
      String.to_existing_atom(options[:type])
    )

    GenServer.start_link(
      InutileDB.Networking.TCP.Server,
      %{
        worker_module: worker_module,
        port: options[:port]
      }
    )
  end

  defp determine_worker_module(type_atom) do
    type_map = %{
      directory: InutileDB.Workers.DirectoryWorker,
      data: "hello!"
    }

    worker_module = type_map[type_atom]

    if (worker_module === nil) do
      raise KeyError, message: "Unable to determine node type"
    end

    worker_module
  end

  defp get_options() do
    { options, _, _ } = OptionParser.parse(
      System.argv(),

      switches: [
        port: :integer,
        type: :string,
      ],

      aliases: [
        p: :port,
        t: :type,
      ]
    )

    IO.inspect(options)

    options
  end
end
