defmodule HelloPhxBulmaWeb.FlashMessage do
  use HelloPhxBulmaWeb, :component

  @flash_keys [
    :danger,
    :dark,
    :error,
    :info,
    :light,
    :primary,
    :success,
    :warning
  ]

  defp flash_keys, do: @flash_keys

  @spec flash_message(map) :: Phoenix.LiveView.Rendered.t()
  def flash_message(assigns) do
    ~H"""
    <%= for flash_key <- flash_keys() do %>
      <%= assigns |> Map.put(:flash_key, flash_key) |> bulma_notification() %>
    <% end %>
    """
  end

  defp bulma_notification(%{conn: conn, flash_key: flash_key}) do
    msg = Phoenix.Controller.get_flash(conn, flash_key)
    bulma_notification(%{msg: msg, flash_key: flash_key})
  end

  defp bulma_notification(%{flash: flash, flash_key: flash_key}) do
    msg = live_flash(flash, flash_key)
    bulma_notification(%{msg: msg, flash_key: flash_key})
  end

  defp bulma_notification(%{msg: msg} = assigns) when is_nil(msg), do: ~H""

  defp bulma_notification(%{msg: _} = assigns) do
    ~H"""
    <div
      class={build_classes(@flash_key)}
      role="alert"
      phx-click="lv:clear-flash"
      phx-value-key={@flash_key}
    >
      <%= @msg %>
    </div>
    """
  end

  defp build_classes(flash_key) do
    ['flash-message', 'notification', flash_key_to_class(flash_key)]
    |> Enum.intersperse(' ')
  end

  defp flash_key_to_class(:danger), do: "is-danger"
  defp flash_key_to_class(:dark), do: "is-dark"
  defp flash_key_to_class(:error), do: "is-danger"
  defp flash_key_to_class(:info), do: "is-info"
  defp flash_key_to_class(:light), do: "is-light"
  defp flash_key_to_class(:primary), do: "is-primary"
  defp flash_key_to_class(:success), do: "is-success"
  defp flash_key_to_class(:warning), do: "is-warning"
end
