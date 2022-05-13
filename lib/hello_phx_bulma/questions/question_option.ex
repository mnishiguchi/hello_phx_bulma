defmodule HelloPhxBulma.Questions.QuestionOption do
  use Ecto.Schema
  import Ecto.Changeset

  alias HelloPhxBulma.Questions.Question

  schema "question_options" do
    field :content, :string
    field :correct, :boolean, default: false

    belongs_to :question, Question

    timestamps()
  end

  @doc """
  Prepares a new instance.
  """
  def new(%Question{} = question, attrs \\ %{}) do
    question_option_attrs = Enum.into(attrs, %{question: question})
    Ecto.build_assoc(question, :question_options, question_option_attrs)
  end

  @doc false
  def changeset(question_option, attrs) do
    question_option
    |> cast(attrs, [:content, :correct, :question_id])
    |> validate_required([:content, :correct, :question_id])
    |> assoc_constraint(:question)
    |> unique_constraint([:content, :question_id])
  end
end
