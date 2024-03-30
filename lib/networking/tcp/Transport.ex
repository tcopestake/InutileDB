defmodule InutileDB.Networking.TCP.Transport do
  @moduledoc """
  Implementation of data transport to/from a client, via TCP.
  """

  @behaviour InutileDB.Transport

  defmacro __using__(_opts) do
  end

  def read(socket) when is_port(socket) do
    :gen_tcp.recv(socket, 0)
  end

  def read(_client_definition), do: { :error, :unsupported_protocol }

  def send(socket, data) when is_port(socket) do
    :gen_tcp.send(socket, data)
  end

  def send(_client_definition, _data), do: { :error, :unsupported_protocol }
end
