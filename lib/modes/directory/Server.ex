defmodule InutileDB.Modes.Directory.Server do
  use InutileDB.Networking.TCP.Server

  @impl true
  def init(options) do
    do_init({ options, InutileDB.Modes.Directory.Worker })
  end
end
