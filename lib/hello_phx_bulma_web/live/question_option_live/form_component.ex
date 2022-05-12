defmodule HelloPhxBulmaWeb.QuestionOptionLive.FormComponent do
  use HelloPhxBulmaWeb, :live_component

  alias HelloPhxBulma.Questions

  @impl true
  def update(%{question_option: question_option} = assigns, socket) do
    changeset = Questions.change_question_option(question_option)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
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
