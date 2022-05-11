defmodule HelloPhxBulmaWeb.HomeLive do
  use HelloPhxBulmaWeb, :surface_view

  alias HelloPhxBulmaWeb.Components.Hero
  alias SurfaceBulma.Title
  alias SurfaceBulma.SubTitle
  import HelloPhxBulma.Countdown

  def mount(_params, _session, socket) do
    if connected?(socket) do
      :timer.send_interval(1000, self(), :tick)
    end

    new_years_day = ~U[1979-01-01 00:00:00.000000Z] |> struct(year: DateTime.utc_now().year + 1)

    {:ok,
     socket
     |> assign_time_remaining(expiration_time: new_years_day)}
  end

  def render(assigns) do
    ~F"""
    <Hero color="light">
      <Title size="2" spaced>我々ハ錬金術師我ガ友ヨ</Title>
      <SubTitle size="5">
        いろはにほへとちりぬるを<br>
        わかよたれそつねならむ<br>
        うゐのおくやまけふこえて<br>
        あさきゆめみしゑひもせすん
      </SubTitle>

      <div class="block">
        <a href="https://autoracex.connpass.com" class="button is-primary">Get Started</a>
      </div>

      <p class="block">
        {humanize_time_remaining(@time_remaining)}
      </p>
    </Hero>
    """
  end

  def handle_info(:tick, socket) do
    {:noreply,
     socket
     |> assign_time_remaining()}
  end

  defp assign_time_remaining(socket, opts \\ []) do
    expiration_time = opts[:expiration_time] || socket.assigns.expiration_time
    time_remaining = calculate_time_remaining(expiration_time)

    socket
    |> assign(expiration_time: expiration_time)
    |> assign(time_remaining: time_remaining)
  end
end
