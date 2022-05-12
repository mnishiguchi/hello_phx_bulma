defmodule HelloPhxBulmaWeb.QuestionOptionLive.Index do
  use HelloPhxBulmaWeb, :live_view

  alias HelloPhxBulma.Questions
  alias HelloPhxBulma.Questions.QuestionOption

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :question_options, list_question_options())}
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
    |> assign(:question_option, %QuestionOption{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Question options")
    |> assign(:question_option, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    question_option = Questions.get_question_option!(id)
    {:ok, _} = Questions.delete_question_option(question_option)

    {:noreply, assign(socket, :question_options, list_question_options())}
  end

  defp list_question_options do
    Questions.list_question_options()
  end
end
