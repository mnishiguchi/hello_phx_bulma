defmodule HelloPhxBulmaWeb.QuestionOptionLive.Index do
  use HelloPhxBulmaWeb, :surface_live_view

  alias SurfaceBulma.Title
  alias HelloPhxBulma.Repo
  alias HelloPhxBulma.Questions
  alias HelloPhxBulma.Questions.QuestionOption

  @impl true
  def mount(%{"question_id" => question_id}, _session, socket) do
    {:ok,
     socket
     |> ensure_question_and_question_options(question_id)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Question option")
    |> assign(:question_option, Questions.get_question_option!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Question option")
    |> assign(:question_option, QuestionOption.new(socket.assigns.question))
  end

  defp ensure_question_and_question_options(socket, question_id) do
    question =
      Questions.get_question!(question_id || socket.assigns.question.id)
      |> Repo.preload(:question_options)

    socket
    |> assign(:question, question)
    |> assign(:question_options, question.question_options)
  end
end
