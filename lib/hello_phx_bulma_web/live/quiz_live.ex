defmodule HelloPhxBulmaWeb.QuizLive do
  use HelloPhxBulmaWeb, :surface_live_view

  alias SurfaceBulma.Title
  alias HelloPhxBulma.Questions
  alias HelloPhxBulmaWeb.Components.QuizQuestion

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> ensure_questions()
     |> assign(current_question_index: 0)}
  end

  def render(assigns) do
    ~F"""
    <Title size="2" spaced>Quiz</Title>
    <QuizQuestion
      id="main-quiz"
      question={@question_lookup |> Map.fetch!(@current_question_index)}
      answer_event="evaluate-answer"
    />
    <div phx-hook="ConfettiHook" id="confetti" />
    """
  end

  def handle_event("evaluate-answer", %{"id" => question_option_id}, socket) do
    case answer_correct?(socket, question_option_id) do
      true ->
        case quiz_completed?(socket) do
          true ->
            Process.send_after(self(), :congratulate, 2500)

            {:noreply,
             socket
             |> clear_flash()
             |> put_flash(:success, "Congratulations")
             |> push_event("mn:confetti", %{size: 2, count: 80})}

          false ->
            {:noreply,
             socket
             |> clear_flash()
             |> push_event("mn:confetti", %{size: 1})
             |> put_flash(:info, "Correct")
             |> update(:current_question_index, &(&1 + 1))}
        end

      false ->
        {:noreply,
         socket
         |> clear_flash()
         |> put_flash(:dark, "Wrong")}
    end
  end

  def handle_info(:congratulate, socket) do
    {:noreply,
     socket
     |> put_flash(:success, "Congratulations")
     |> push_redirect(to: "/")}
  end

  defp answer_correct?(socket, question_option_id) do
    current_question =
      socket.assigns.question_lookup
      |> Map.fetch!(socket.assigns.current_question_index)

    selected_question_option =
      current_question.question_options
      |> Enum.find(&(to_string(&1.id) == question_option_id))

    selected_question_option.correct
  end

  defp quiz_completed?(socket) do
    socket.assigns.current_question_index >= socket.assigns.question_count - 1
  end

  defp ensure_questions(socket) do
    questions = Questions.list_questions_for_quiz()
    question_count = length(questions)
    question_lookup = Enum.zip(0..(question_count - 1), questions) |> Map.new()

    socket
    |> assign(question_lookup: question_lookup)
    |> assign(question_count: question_count)
  end
end
