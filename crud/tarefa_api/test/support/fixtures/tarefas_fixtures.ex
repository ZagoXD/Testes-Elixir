defmodule TarefaApi.TarefasFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TarefaApi.Tarefas` context.
  """

  @doc """
  Generate a tarefa.
  """
  def tarefa_fixture(attrs \\ %{}) do
    {:ok, tarefa} =
      attrs
      |> Enum.into(%{
        description: "some description",
        is_completed: true,
        title: "some title"
      })
      |> TarefaApi.Tarefas.create_tarefa()

    tarefa
  end
end
