defmodule BookManagerWeb.BookControllerTest do
  use BookManagerWeb.ConnCase

  alias BookManager.Library
  alias BookManager.Library.Book

  @valid_attrs %{title: "Elixir in Action", author: "Sasa Juric", published_year: 2019}
  @invalid_attrs %{title: nil, author: nil, published_year: nil}

  setup do
    {:ok, book: Library.create_book!(@valid_attrs)}
  end

  test "GET /api/books returns all books", %{conn: conn} do
    conn = get(conn, Routes.book_path(conn, :index))
    assert json_response(conn, 200)["data"] != []
  end

  test "POST /api/books creates a book with valid data", %{conn: conn} do
    conn = post(conn, Routes.book_path(conn, :create), book: @valid_attrs)
    assert json_response(conn, 201)["data"]["title"] == "Elixir in Action"
  end

  test "POST /api/books fails with invalid data", %{conn: conn} do
    conn = post(conn, Routes.book_path(conn, :create), book: @invalid_attrs)
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "GET /api/books/:id returns the book", %{conn: conn, book: book} do
    conn = get(conn, Routes.book_path(conn, :show, book))
    assert json_response(conn, 200)["data"]["id"] == book.id
  end

  test "DELETE /api/books/:id deletes the book", %{conn: conn, book: book} do
    conn = delete(conn, Routes.book_path(conn, :delete, book))
    assert response(conn, 204)
  end
end
