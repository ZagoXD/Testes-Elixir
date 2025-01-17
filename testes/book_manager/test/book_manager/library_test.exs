defmodule BookManager.LibraryTest do
  use BookManager.DataCase

  alias BookManager.Library
  alias BookManager.Library.Book

  describe "books" do
    @valid_attrs %{title: "Elixir in Action", author: "Sasa Juric", published_year: 2019}
    @invalid_attrs %{title: nil, author: nil, published_year: nil}

    test "list_books/0 returns all books" do
      book = Library.create_book!(@valid_attrs)
      assert Library.list_books() == [book]
    end

    test "get_book!/1 returns the book with the given id" do
      book = Library.create_book!(@valid_attrs)
      assert Library.get_book!(book.id) == book
    end

    test "create_book/1 with valid data creates a book" do
      assert {:ok, %Book{} = book} = Library.create_book(@valid_attrs)
      assert book.title == "Elixir in Action"
    end

    test "create_book/1 with invalid data returns an error changeset" do
      assert {:error, changeset} = Library.create_book(@invalid_attrs)
      refute changeset.valid?
    end

    test "update_book/2 with valid data updates the book" do
      book = Library.create_book!(@valid_attrs)
      update_attrs = %{title: "Updated Title"}

      assert {:ok, %Book{} = updated_book} = Library.update_book(book, update_attrs)
      assert updated_book.title == "Updated Title"
    end

    test "delete_book/1 deletes the book" do
      book = Library.create_book!(@valid_attrs)
      assert {:ok, %Book{}} = Library.delete_book(book)
      assert_raise Ecto.NoResultsError, fn -> Library.get_book!(book.id) end
    end
  end
end
