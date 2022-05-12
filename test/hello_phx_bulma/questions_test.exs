defmodule HelloPhxBulma.QuestionsTest do
  use HelloPhxBulma.DataCase

  alias HelloPhxBulma.Questions

  describe "questions" do
    alias HelloPhxBulma.Questions.Question

    import HelloPhxBulma.QuestionsFixtures

    @invalid_attrs %{content: nil, help_text: nil}

    test "list_questions/0 returns all questions" do
      question = question_fixture()
      assert Questions.list_questions() == [question]
    end

    test "get_question!/1 returns the question with given id" do
      question = question_fixture()
      assert Questions.get_question!(question.id) == question
    end

    test "create_question/1 with valid data creates a question" do
      valid_attrs = %{content: "some content", help_text: "some help_text"}

      assert {:ok, %Question{} = question} = Questions.create_question(valid_attrs)
      assert question.content == "some content"
      assert question.help_text == "some help_text"
    end

    test "create_question/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Questions.create_question(@invalid_attrs)
    end

    test "update_question/2 with valid data updates the question" do
      question = question_fixture()
      update_attrs = %{content: "some updated content", help_text: "some updated help_text"}

      assert {:ok, %Question{} = question} = Questions.update_question(question, update_attrs)
      assert question.content == "some updated content"
      assert question.help_text == "some updated help_text"
    end

    test "update_question/2 with invalid data returns error changeset" do
      question = question_fixture()
      assert {:error, %Ecto.Changeset{}} = Questions.update_question(question, @invalid_attrs)
      assert question == Questions.get_question!(question.id)
    end

    test "delete_question/1 deletes the question" do
      question = question_fixture()
      assert {:ok, %Question{}} = Questions.delete_question(question)
      assert_raise Ecto.NoResultsError, fn -> Questions.get_question!(question.id) end
    end

    test "change_question/1 returns a question changeset" do
      question = question_fixture()
      assert %Ecto.Changeset{} = Questions.change_question(question)
    end
  end

  describe "question_options" do
    alias HelloPhxBulma.Questions.QuestionOption

    import HelloPhxBulma.QuestionsFixtures

    @invalid_attrs %{content: nil, correct: nil}

    test "list_question_options/0 returns all question_options" do
      question_option = question_option_fixture()
      assert Questions.list_question_options() == [question_option]
    end

    test "get_question_option!/1 returns the question_option with given id" do
      question_option = question_option_fixture()
      assert Questions.get_question_option!(question_option.id) == question_option
    end

    test "create_question_option/1 with valid data creates a question_option" do
      valid_attrs = %{content: "some content", correct: true}

      assert {:ok, %QuestionOption{} = question_option} = Questions.create_question_option(valid_attrs)
      assert question_option.content == "some content"
      assert question_option.correct == true
    end

    test "create_question_option/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Questions.create_question_option(@invalid_attrs)
    end

    test "update_question_option/2 with valid data updates the question_option" do
      question_option = question_option_fixture()
      update_attrs = %{content: "some updated content", correct: false}

      assert {:ok, %QuestionOption{} = question_option} = Questions.update_question_option(question_option, update_attrs)
      assert question_option.content == "some updated content"
      assert question_option.correct == false
    end

    test "update_question_option/2 with invalid data returns error changeset" do
      question_option = question_option_fixture()
      assert {:error, %Ecto.Changeset{}} = Questions.update_question_option(question_option, @invalid_attrs)
      assert question_option == Questions.get_question_option!(question_option.id)
    end

    test "delete_question_option/1 deletes the question_option" do
      question_option = question_option_fixture()
      assert {:ok, %QuestionOption{}} = Questions.delete_question_option(question_option)
      assert_raise Ecto.NoResultsError, fn -> Questions.get_question_option!(question_option.id) end
    end

    test "change_question_option/1 returns a question_option changeset" do
      question_option = question_option_fixture()
      assert %Ecto.Changeset{} = Questions.change_question_option(question_option)
    end
  end
end
