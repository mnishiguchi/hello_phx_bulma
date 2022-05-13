defmodule HelloPhxBulma.Questions.Question do
  use Ecto.Schema
  import Ecto.Changeset

  alias HelloPhxBulma.Questions.QuestionOption

  schema "questions" do
    field :content, :string
    field :help_text, :string

    has_many :question_options, QuestionOption, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:content, :help_text])
    |> validate_required([:content])
    |> cast_assoc(:question_options, with: &QuestionOption.changeset/2)
  end
end
