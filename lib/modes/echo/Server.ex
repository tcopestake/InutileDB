defmodule InutileDB.Modes.Echo.Server do
  use InutileDB.Networking.TCP.Server

  @impl true
  def init(options) do
    do_init({ options, InutileDB.Modes.Echo.Worker })
  end
end
