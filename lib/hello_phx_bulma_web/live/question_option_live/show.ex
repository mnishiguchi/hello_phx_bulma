defmodule HelloPhxBulmaWeb.QuestionOptionLive.Show do
  use HelloPhxBulmaWeb, :live_view

  alias HelloPhxBulma.Questions

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:question_option, Questions.get_question_option!(id))}
  end

  defp page_title(:show), do: "Show Question option"
  defp page_title(:edit), do: "Edit Question option"
end
