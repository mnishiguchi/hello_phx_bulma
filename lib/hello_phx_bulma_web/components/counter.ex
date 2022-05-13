defmodule HelloPhxBulmaWeb.Components.Counter do
  use HelloPhxBulmaWeb, :surface_live_component

  data count, :integer, default: 0

  def render(assigns) do
    ~F"""
    <div>
      <h1 class="title">
        {@count}
      </h1>
      <div>
        <button class="button is-info" :on-click="dec">
          -
        </button>
        <button class="button is-info" :on-click="inc">
          +
        </button>
      </div>
    </div>
    """
  end

  def handle_event("inc", _value, socket) do
    {:noreply, update(socket, :count, &(&1 + 1))}
  end

  def handle_event("dec", _value, socket) do
    {:noreply, update(socket, :count, &(&1 - 1))}
  end
end
