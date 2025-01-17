defmodule BookManager.LibraryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BookManager.Library` context.
  """

  @doc """
  Generate a book.
  """
  def book_fixture(attrs \\ %{}) do
    {:ok, book} =
      attrs
      |> Enum.into(%{
        author: "some author",
        published_year: 42,
        title: "some title"
      })
      |> BookManager.Library.create_book()

    book
  end
end
