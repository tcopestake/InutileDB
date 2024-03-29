defmodule TCPServer do
  use Application

  def start(_type, _args) do
    listen()
  end

  def listen() do
    {:ok, listen_socket} = :gen_tcp.listen(1234, [:binary, active: false])

    accept_next(listen_socket)
  end

  def accept_next(listen_socket) do
    {:ok, client_socket} = :gen_tcp.accept(listen_socket)

    GenServer.start_link(TCPWorker, client_socket)

    accept_next(listen_socket)
  end
end
