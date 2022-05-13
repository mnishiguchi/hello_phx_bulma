defmodule HelloPhxBulma.Init do
  alias HelloPhxBulma.Accounts
  alias HelloPhxBulma.Accounts.User
  alias HelloPhxBulma.Questions

  @doc """
  Seeds example records into database. Do not use this in production.
  """
  @spec seed! :: :ok
  def seed! do
    get_or_insert_user!(
      email: "user@example.com",
      password: "userpassword"
    )

    for x <- 1..3, y <- 1..3 do
      {:ok, question} =
        Questions.create_question(%{
          content: "#{x} x #{y}",
          help_text: "just multiply #{x} by #{y}"
        })

      {:ok, _} =
        Questions.create_question_option(question, %{
          content: "#{x * y}",
          correct: true
        })

      {:ok, _} =
        Questions.create_question_option(question, %{
          content: :crypto.strong_rand_bytes(8) |> Base.encode16()
        })

      {:ok, _} =
        Questions.create_question_option(question, %{
          content: :crypto.strong_rand_bytes(8) |> Base.encode16()
        })
    end

    :ok
  end

  @spec get_or_insert_user!(keyword()) :: User.t()
  def get_or_insert_user!(opts \\ []) do
    user_email = Access.fetch!(opts, :email)
    user_password = Access.fetch!(opts, :password)

    case Accounts.get_user_by_email(user_email) do
      nil ->
        {:ok, user} = Accounts.register_user(%{email: user_email, password: user_password})
        user

      %User{} = user ->
        user
    end
  end
end
