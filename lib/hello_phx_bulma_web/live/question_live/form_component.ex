defmodule HelloPhxBulmaWeb.QuestionLive.FormComponent do
  use HelloPhxBulmaWeb, :surface_live_component

  alias SurfaceBulma.Title
  alias SurfaceBulma.Form
  alias HelloPhxBulma.Questions

  prop title, :struct, required: true

  data changeset, :struct

  def update(%{question: question} = assigns, socket) do
    changeset = Questions.change_question(question)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  def render(assigns) do
    ~F"""
    <div>
      <Title size="4">{@title}</Title>

      <Form for={@changeset} change="validate" submit="save" opts={id: "question-form"} :let={form: f}>
        {bulma_input(f, :content, using: :textarea, autocomplete: "off", phx_debounce: "250")}
        {bulma_input(f, :help_text, using: :textarea, autocomplete: "off", phx_debounce: "250")}

        <div class="control mt-4">
          {submit("Save", phx_disable_with: "Saving...", class: "button is-primary")}
        </div>
      </Form>
    </div>
    """
  end

  def handle_event("validate", %{"question" => question_params}, socket) do
    changeset =
      socket.assigns.question
      |> Questions.change_question(question_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"question" => question_params}, socket) do
    save_question(socket, socket.assigns.action, question_params)
  end

  defp save_question(socket, :edit, question_params) do
    case Questions.update_question(socket.assigns.question, question_params) do
      {:ok, _question} ->
        {:noreply,
         socket
         |> put_flash(:info, "Question updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_question(socket, :new, question_params) do
    case Questions.create_question(question_params) do
      {:ok, _question} ->
        {:noreply,
         socket
         |> put_flash(:info, "Question created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
