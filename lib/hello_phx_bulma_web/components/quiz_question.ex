defmodule HelloPhxBulmaWeb.Components.QuizQuestion do
  use HelloPhxBulmaWeb, :surface_live_component

  prop question, :struct, required: true
  prop answer_event, :event, required: true

  def render(assigns) do
    if Enum.empty?(assigns.question.question_options) do
      raise("question must have question options")
    end

    ~F"""
    <div>
      <div class="block">
        <p>{@question.content}</p>
        <details :if={@question.help_text}>
          <summary>{gettext("Hint")}</summary>
          {@question.help_text}
        </details>
      </div>

      <div class="block">
        {#for question_option <- @question.question_options |> Enum.shuffle()}
          <button class="button is-info" :on-click={@answer_event} phx-value-id={question_option.id}>
            {question_option.content}
          </button>
        {/for}
      </div>
    </div>
    """
  end
end
