defmodule Webdsl.Handler do
  @behaviour :cowboy_handler

  @impl :cowboy_handler
  def init(req, state) do
    req = :cowboy_req.reply(200, %{"content-type" => "text/plain"}, "Hello from Webdsl!", req)
    {:ok, req, state}
  end

  defmodule NotFound do
    @behaviour :cowboy_handler

    @impl :cowboy_handler
    def init(req, state) do
      req = :cowboy_req.reply(404, %{"content-type" => "text/plain"}, "Not found", req)
      {:ok, req, state}
    end
  end
end
