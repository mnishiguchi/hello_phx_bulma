defmodule HelloPhxBulma.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:questions) do
      add :content, :text, null: false
      add :help_text, :text

      timestamps()
    end
  end
end
