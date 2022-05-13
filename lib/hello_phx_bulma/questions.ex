defmodule HelloPhxBulma.Questions do
  @moduledoc """
  The Questions context.
  """

  import Ecto.Query, warn: false
  alias HelloPhxBulma.Repo

  alias HelloPhxBulma.Questions.Question

  @doc """
  Returns the list of questions.

  ## Examples

      iex> list_questions()
      [%Question{}, ...]

  """
  def list_questions do
    Repo.all(Question)
  end

  def list_questions_for_quiz do
    list_questions()
    |> Repo.preload(:question_options)
    |> Enum.reject(fn question -> question.question_options |> Enum.empty?() end)
    |> Enum.shuffle()
  end

  @doc """
  Gets a single question.

  Raises `Ecto.NoResultsError` if the Question does not exist.

  ## Examples

      iex> get_question!(123)
      %Question{}

      iex> get_question!(456)
      ** (Ecto.NoResultsError)

  """
  def get_question!(id), do: Repo.get!(Question, id)

  @doc """
  Creates a question.

  ## Examples

      iex> create_question(%{field: value})
      {:ok, %Question{}}

      iex> create_question(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_question(attrs \\ %{}) do
    %Question{}
    |> Question.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a question.

  ## Examples

      iex> update_question(question, %{field: new_value})
      {:ok, %Question{}}

      iex> update_question(question, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_question(%Question{} = question, attrs) do
    question
    |> Question.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a question.

  ## Examples

      iex> delete_question(question)
      {:ok, %Question{}}

      iex> delete_question(question)
      {:error, %Ecto.Changeset{}}

  """
  def delete_question(%Question{} = question) do
    Repo.delete(question)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking question changes.

  ## Examples

      iex> change_question(question)
      %Ecto.Changeset{data: %Question{}}

  """
  def change_question(%Question{} = question, attrs \\ %{}) do
    Question.changeset(question, attrs)
  end

  alias HelloPhxBulma.Questions.QuestionOption

  @doc """
  Returns the list of question_options.

  ## Examples

      iex> list_question_options()
      [%QuestionOption{}, ...]

  """
  def list_question_options do
    Repo.all(QuestionOption)
  end

  def list_question_options(%Question{} = question) do
    question
    |> Ecto.assoc(:question_options)
    |> Repo.all()
  end

  @doc """
  Gets a single question_option.

  Raises `Ecto.NoResultsError` if the Question option does not exist.

  ## Examples

      iex> get_question_option!(123)
      %QuestionOption{}

      iex> get_question_option!(456)
      ** (Ecto.NoResultsError)

  """
  def get_question_option!(id), do: Repo.get!(QuestionOption, id)

  @doc """
  Creates a question_option.

  ## Examples

      iex> create_question_option(%{field: value})
      {:ok, %QuestionOption{}}

      iex> create_question_option(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_question_option(attrs) do
    %QuestionOption{}
    |> QuestionOption.changeset(attrs)
    |> Repo.insert()
  end

  def create_question_option(%Question{} = question, attrs) do
    question
    |> Ecto.build_assoc(:question_options)
    |> QuestionOption.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a question_option.

  ## Examples

      iex> update_question_option(question_option, %{field: new_value})
      {:ok, %QuestionOption{}}

      iex> update_question_option(question_option, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_question_option(%QuestionOption{} = question_option, attrs) do
    question_option
    |> QuestionOption.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a question_option.

  ## Examples

      iex> delete_question_option(question_option)
      {:ok, %QuestionOption{}}

      iex> delete_question_option(question_option)
      {:error, %Ecto.Changeset{}}

  """
  def delete_question_option(%QuestionOption{} = question_option) do
    Repo.delete(question_option)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking question_option changes.

  ## Examples

      iex> change_question_option(question_option)
      %Ecto.Changeset{data: %QuestionOption{}}

  """
  def change_question_option(%QuestionOption{} = question_option, attrs \\ %{}) do
    QuestionOption.changeset(question_option, attrs)
  end
end
