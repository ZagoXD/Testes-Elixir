defmodule BookManagerWeb.BookJSON do
  alias BookManager.Library.Book

  @doc """
  Renders a list of books.
  """
  def index(%{books: books}) do
    %{data: for(book <- books, do: data(book))}
  end

  @doc """
  Renders a single book.
  """
  def show(%{book: book}) do
    %{data: data(book)}
  end

  defp data(%Book{} = book) do
    %{
      id: book.id,
      title: book.title,
      author: book.author,
      published_year: book.published_year
    }
  end
end
