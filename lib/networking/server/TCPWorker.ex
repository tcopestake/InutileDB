defmodule TCPWorker do
  use GenServer

  @impl true
  def init(socket) do
    GenServer.cast(self(), { :handle_connection, socket })

    { :ok, :started }
  end

  @impl true
  def handle_cast({ :handle_connection, socket }, state) do
    process(socket)

    { :noreply, state }
  end

  defp process(socket) do
    { :ok, data } = :gen_tcp.recv(socket, 0)

    loop(socket, data)
  end

  defp loop(socket, data) do
      case :gen_tcp.send(socket, "[y0: ") do
        :ok ->
          :gen_tcp.send(socket, data)

          :gen_tcp.send(socket, "]")

          :timer.sleep(2000)

          loop(socket, data)

        { :error, reason } ->
          IO.puts("error: #{reason}")

      end
  end
end
