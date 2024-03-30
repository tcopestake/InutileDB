defmodule InutileDB.Workers.DirectoryWorker do
  use GenServer

  @impl true
  def init(transport) do
    GenServer.cast(self(), { :handle_connection, transport })

    { :ok, :started }
  end

  @impl true
  def handle_cast({ :handle_connection, { transport_module, client_definition } }, _state) do
    { :ok, data } = transport_module.read(client_definition)

    continue({
      :reading,
      transport_module,
      client_definition,
      data
    })
  end

  @impl true
  def handle_continue(:data_loop, { :reading, transport_module, client_definition, data } = state) do
    result = loop(transport_module, client_definition, data)

    case result do
      :ok -> continue(state)
      _ -> { :stop, :normal, state }
    end
  end

  defp loop(transport_module, client_definition, data) do
    transport_module.send(client_definition, "[y0: ")
    transport_module.send(client_definition, data)
    result = transport_module.send(client_definition, "]")

    :timer.sleep(1500)

    case result do
      :ok -> :ok
      _ -> end_connection()
    end
  end

  defp end_connection() do
    IO.puts("Encountered error when sending data to client.")

    :end_connection
  end

  defp continue(state) do
    { :noreply, state, { :continue, :data_loop } }
  end
end
