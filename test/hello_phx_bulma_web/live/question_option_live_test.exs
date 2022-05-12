defmodule HelloPhxBulmaWeb.QuestionOptionLiveTest do
  use HelloPhxBulmaWeb.ConnCase

  import Phoenix.LiveViewTest
  import HelloPhxBulma.QuestionsFixtures

  @create_attrs %{content: "some content", correct: true}
  @update_attrs %{content: "some updated content", correct: false}
  @invalid_attrs %{content: nil, correct: false}

  defp create_question_option(_) do
    question_option = question_option_fixture()
    %{question_option: question_option}
  end

  describe "Index" do
    setup [:create_question_option]

    test "lists all question_options", %{conn: conn, question_option: question_option} do
      {:ok, _index_live, html} = live(conn, Routes.question_option_index_path(conn, :index))

      assert html =~ "Listing Question options"
      assert html =~ question_option.content
    end

    test "saves new question_option", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.question_option_index_path(conn, :index))

      assert index_live |> element("a", "New Question option") |> render_click() =~
               "New Question option"

      assert_patch(index_live, Routes.question_option_index_path(conn, :new))

      assert index_live
             |> form("#question_option-form", question_option: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#question_option-form", question_option: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.question_option_index_path(conn, :index))

      assert html =~ "Question option created successfully"
      assert html =~ "some content"
    end

    test "updates question_option in listing", %{conn: conn, question_option: question_option} do
      {:ok, index_live, _html} = live(conn, Routes.question_option_index_path(conn, :index))

      assert index_live |> element("#question_option-#{question_option.id} a", "Edit") |> render_click() =~
               "Edit Question option"

      assert_patch(index_live, Routes.question_option_index_path(conn, :edit, question_option))

      assert index_live
             |> form("#question_option-form", question_option: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#question_option-form", question_option: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.question_option_index_path(conn, :index))

      assert html =~ "Question option updated successfully"
      assert html =~ "some updated content"
    end

    test "deletes question_option in listing", %{conn: conn, question_option: question_option} do
      {:ok, index_live, _html} = live(conn, Routes.question_option_index_path(conn, :index))

      assert index_live |> element("#question_option-#{question_option.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#question_option-#{question_option.id}")
    end
  end

  describe "Show" do
    setup [:create_question_option]

    test "displays question_option", %{conn: conn, question_option: question_option} do
      {:ok, _show_live, html} = live(conn, Routes.question_option_show_path(conn, :show, question_option))

      assert html =~ "Show Question option"
      assert html =~ question_option.content
    end

    test "updates question_option within modal", %{conn: conn, question_option: question_option} do
      {:ok, show_live, _html} = live(conn, Routes.question_option_show_path(conn, :show, question_option))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Question option"

      assert_patch(show_live, Routes.question_option_show_path(conn, :edit, question_option))

      assert show_live
             |> form("#question_option-form", question_option: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#question_option-form", question_option: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.question_option_show_path(conn, :show, question_option))

      assert html =~ "Question option updated successfully"
      assert html =~ "some updated content"
    end
  end
end
