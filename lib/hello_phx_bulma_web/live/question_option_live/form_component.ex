defmodule HelloPhxBulmaWeb.QuestionOptionLive.FormComponent do
  use HelloPhxBulmaWeb, :surface_live_component

  alias SurfaceBulma.Title
  alias SurfaceBulma.Form
  alias HelloPhxBulma.Questions

  prop title, :struct, required: true

  data changeset, :struct

  def update(%{question_option: question_option} = assigns, socket) do
    changeset = Questions.change_question_option(question_option)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  def render(assigns) do
    ~F"""
    <div>
      <Title size="4">{@title}</Title>

      <Form
        for={@changeset}
        change="validate"
        submit="save"
        opts={id: "question_option-form"}
        :let={form: f}
      >
        {hidden_inputs_for(f)}
        {hidden_input(f, :question_id)}
        {error_tag(f, :question_id)}

        {bulma_input(f, :content, using: :textarea, autocomplete: "off", phx_debounce: "250")}
        {bulma_checkbox(f, :correct)}

        <div class="control mt-4">
          {submit("Save", phx_disable_with: "Saving...", class: "button is-primary")}
        </div>
      </Form>
    </div>
    """
  end

  def handle_event("validate", %{"question_option" => question_option_params}, socket) do
    changeset =
      socket.assigns.question_option
      |> Questions.change_question_option(question_option_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"question_option" => question_option_params}, socket) do
    save_question_option(socket, socket.assigns.action, question_option_params)
  end

  defp save_question_option(socket, :edit, question_option_params) do
    case Questions.update_question_option(socket.assigns.question_option, question_option_params) do
      {:ok, _question_option} ->
        {:noreply,
         socket
         |> put_flash(:info, "Question option updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_question_option(socket, :new, question_option_params) do
    case Questions.create_question_option(question_option_params) do
      {:ok, _question_option} ->
        {:noreply,
         socket
         |> put_flash(:info, "Question option created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
