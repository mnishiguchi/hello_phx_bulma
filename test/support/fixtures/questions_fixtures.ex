defmodule HelloPhxBulma.QuestionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HelloPhxBulma.Questions` context.
  """

  alias HelloPhxBulma.Questions
  alias HelloPhxBulma.Questions.Question

  @doc """
  Generate a question.
  """
  def question_fixture(attrs \\ %{}) do
    {:ok, question} =
      attrs
      |> Enum.into(%{
        content: "some content",
        help_text: "some help_text"
      })
      |> Questions.create_question()

    question
  end

  @doc """
  Generate a question_option.
  """
  def question_option_fixture(%Question{} = question, attrs \\ %{}) do
    {:ok, question_option} =
      attrs
      |> Enum.into(%{
        question_id: question.id,
        content: "some content",
        correct: true
      })
      |> Questions.create_question_option()

    question_option
  end
end
