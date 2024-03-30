defmodule InutileDB.Networking.TCP.Server do
  use GenServer

  defmacro __using__(_opts) do
  end

  @impl true
  def init(options) do
    GenServer.cast(self(), { :accept_connections, options })

    { :ok, :started }
  end

  @impl true
  def handle_cast({ :accept_connections, options }, _state) do
    { :ok, listen_socket } = :gen_tcp.listen(options.port, [ :binary, active: false ])

    continue({
      :accepting_connections,
      listen_socket,
      options.worker_module
    })
  end

  @impl true
  def handle_continue(
    :accepting_connections,
    { :accepting_connections, listen_socket, worker_module } = state
  ) do
    accept_next(listen_socket, worker_module)

    continue(state)
  end

  defp continue(state) do
    { :noreply, state, { :continue, :accepting_connections } }
  end

  defp accept_next(listen_socket, worker_module) do
    { :ok, client_socket } = :gen_tcp.accept(listen_socket)

    GenServer.start_link(worker_module, {
      InutileDB.Networking.TCP.Transport,
      client_socket,
    })
  end
end
