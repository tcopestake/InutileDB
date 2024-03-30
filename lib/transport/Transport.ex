defmodule InutileDB.Transport do
  @moduledoc """
  This defines an "interface" for sending data to - and receiving
  data from - a given client, via some arbitrary communication channel.
  """

  @callback send(channel :: any, data :: any) :: { :error, any() } | :ok
  @callback read(channel :: any) :: { :error, any() } | { :ok, any() }
end
