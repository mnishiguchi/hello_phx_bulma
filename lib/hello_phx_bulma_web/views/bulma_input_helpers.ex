defmodule HelloPhxBulmaWeb.BulmaInputHelpers do
  use Phoenix.HTML

  @doc """
  Dynamically generates a form input field. Some input type can be inferred from the field name.
  http://blog.plataformatec.com.br/2016/09/dynamic-forms-with-phoenix/

  ## Examples

      bulma_input f, :name, placeholder: "Name", autocomplete: "off"
      bulma_input f, :phone, using: :telephone_input, placeholder: "Phone", autocomplete: "off"

  """
  def bulma_input(form, field, opts \\ []) do
    label_opts = Keyword.take(opts, ~w[required label]a)
    input_opts = Keyword.drop(opts, ~w[required label]a)

    content_tag :div, class: "field" do
      [
        build_label(form, field, label_opts),
        build_input(form, field, input_opts),
        HelloPhxBulmaWeb.ErrorHelpers.error_tag(form, field)
      ]
    end
  end

  defp build_label(form, field, opts) do
    required = opts[:required] || Keyword.get(input_validations(form, field), :required)
    label_text = (opts[:label] || humanize(field)) <> if required, do: " *", else: ""

    Phoenix.HTML.Form.label(form, field, label_text, class: "label")
  end

  defp build_input(form, field, opts) do
    input_fun_name = opts[:using] || Phoenix.HTML.Form.input_type(form, field)
    permitted_attributes = Keyword.drop(opts, [:using])

    input_class =
      case input_fun_name do
        :textarea -> "textarea "
        _ -> "input "
      end <> form_state_class(form, field)

    input_opts =
      [{:class, input_class} | permitted_attributes]
      |> Enum.reject(&is_nil(elem(&1, 1)))

    content_tag :div, class: "control" do
      apply(Phoenix.HTML.Form, input_fun_name, [form, field, input_opts])
    end
  end

  defp form_state_class(form, field) do
    cond do
      # Some forms may not use a Map as a source. E.g., :user
      !is_map(form.source) -> ""
      # Ignore Conn-based form.
      Map.get(form.source, :__struct__) == Plug.Conn -> ""
      # The form is not yet submitted.
      !Map.get(form.source, :action) -> ""
      # This field has an error.
      form.errors[field] -> "is-danger"
      true -> "is-success"
    end
  end
end
