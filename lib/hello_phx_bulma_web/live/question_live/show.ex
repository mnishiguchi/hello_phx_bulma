defmodule HelloPhxBulmaWeb.QuestionLive.Show do
  use HelloPhxBulmaWeb, :surface_live_view

  alias SurfaceBulma.Title
  alias HelloPhxBulma.Questions
  alias HelloPhxBulma.Repo

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => question_id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> ensure_question_and_question_options(question_id)}
  end

  @impl true
  def handle_event("delete-question-option", %{"id" => question_option_id}, socket) do
    question_option = Questions.get_question_option!(question_option_id)
    {:ok, _} = Questions.delete_question_option(question_option)

    {:noreply, ensure_question_and_question_options(socket)}
  end

  defp ensure_question_and_question_options(socket, question_id \\ nil) do
    socket
    |> assign(
      :question,
      Questions.get_question!(question_id || socket.assigns.question.id)
      |> Repo.preload(:question_options)
    )
  end

  defp page_title(:show), do: "Show Question"
  defp page_title(:edit), do: "Edit Question"
end
