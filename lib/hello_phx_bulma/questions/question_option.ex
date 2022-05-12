defmodule HelloPhxBulma.Questions.QuestionOption do
  use Ecto.Schema
  import Ecto.Changeset

  alias Awesomex.Questions.Question

  schema "question_options" do
    field :content, :string
    field :correct, :boolean, default: false

    belongs_to :question, Question

    timestamps()
  end

  @doc false
  def changeset(question_option, attrs) do
    question_option
    |> cast(attrs, [:content, :correct])
    |> validate_required([:content, :correct])
    |> assoc_constraint(:question)
    |> unique_constraint([:content, :question])
  end
end
