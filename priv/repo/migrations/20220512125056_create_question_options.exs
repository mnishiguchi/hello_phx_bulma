defmodule HelloPhxBulma.Repo.Migrations.CreateQuestionOptions do
  use Ecto.Migration

  def change do
    create table(:question_options) do
      add :content, :text, null: false
      add :correct, :boolean, default: false, null: false
      add :question_id, references(:questions, on_delete: :delete_all)

      timestamps()
    end

    create index(:question_options, [:question_id])
    create unique_index(:question_options, [:question_id, :content])
  end
end
