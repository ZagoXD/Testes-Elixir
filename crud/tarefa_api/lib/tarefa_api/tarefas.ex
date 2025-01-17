defmodule TarefaApi.Tarefas do
  @moduledoc """
  The Tarefas context.
  """

  import Ecto.Query, warn: false
  alias TarefaApi.Repo

  alias TarefaApi.Tarefas.Tarefa

  @doc """
  Returns the list of tasks.

  ## Examples

      iex> list_tasks()
      [%Tarefa{}, ...]

  """
  def list_tasks do
    Repo.all(Tarefa)
  end

  @doc """
  Gets a single tarefa.

  Raises `Ecto.NoResultsError` if the Tarefa does not exist.

  ## Examples

      iex> get_tarefa!(123)
      %Tarefa{}

      iex> get_tarefa!(456)
      ** (Ecto.NoResultsError)

  """
  def get_tarefa!(id), do: Repo.get!(Tarefa, id)

  @doc """
  Creates a tarefa.

  ## Examples

      iex> create_tarefa(%{field: value})
      {:ok, %Tarefa{}}

      iex> create_tarefa(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_tarefa(attrs \\ %{}) do
    %Tarefa{}
    |> Tarefa.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a tarefa.

  ## Examples

      iex> update_tarefa(tarefa, %{field: new_value})
      {:ok, %Tarefa{}}

      iex> update_tarefa(tarefa, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_tarefa(%Tarefa{} = tarefa, attrs) do
    tarefa
    |> Tarefa.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a tarefa.

  ## Examples

      iex> delete_tarefa(tarefa)
      {:ok, %Tarefa{}}

      iex> delete_tarefa(tarefa)
      {:error, %Ecto.Changeset{}}

  """
  def delete_tarefa(%Tarefa{} = tarefa) do
    Repo.delete(tarefa)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking tarefa changes.

  ## Examples

      iex> change_tarefa(tarefa)
      %Ecto.Changeset{data: %Tarefa{}}

  """
  def change_tarefa(%Tarefa{} = tarefa, attrs \\ %{}) do
    Tarefa.changeset(tarefa, attrs)
  end
end
