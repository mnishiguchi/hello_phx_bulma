defmodule HelloPhxBulma.QuestionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HelloPhxBulma.Questions` context.
  """

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
      |> HelloPhxBulma.Questions.create_question()

    question
  end

  @doc """
  Generate a question_option.
  """
  def question_option_fixture(attrs \\ %{}) do
    {:ok, question_option} =
      attrs
      |> Enum.into(%{
        content: "some content",
        correct: true
      })
      |> HelloPhxBulma.Questions.create_question_option()

    question_option
  end
end
