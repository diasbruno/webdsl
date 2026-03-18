defmodule Webdsl.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    port = Application.get_env(:webdsl, :port, 4000)

    dispatch =
      :cowboy_router.compile([
        {:_, [{"/", Webdsl.Handler, []}, {:_, Webdsl.Handler.NotFound, []}]}
      ])

    children = [
      :ranch.child_spec(:http, :ranch_tcp, [{:port, port}], :cowboy_clear, %{
        env: %{dispatch: dispatch}
      })
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Webdsl.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
