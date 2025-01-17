defmodule TarefaApiWeb.TarefaJSON do
  alias TarefaApi.Tarefas.Tarefa

  @doc """
  Renders a list of tasks.
  """
  def index(%{tasks: tasks}) do
    %{data: for(tarefa <- tasks, do: data(tarefa))}
  end

  @doc """
  Renders a single tarefa.
  """
  def show(%{tarefa: tarefa}) do
    %{data: data(tarefa)}
  end

  defp data(%Tarefa{} = tarefa) do
    %{
      id: tarefa.id,
      title: tarefa.title,
      description: tarefa.description,
      is_completed: tarefa.is_completed
    }
  end
end
