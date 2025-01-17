defmodule TarefaApiWeb.TarefaController do
  use TarefaApiWeb, :controller

  alias TarefaApi.Tarefas
  alias TarefaApi.Tarefas.Tarefa

  action_fallback TarefaApiWeb.FallbackController

  def index(conn, _params) do
    tasks = Tarefas.list_tasks()
    render(conn, :index, tasks: tasks)
  end

  def create(conn, tarefa_params) do
    with {:ok, %Tarefa{} = tarefa} <- Tarefas.create_tarefa(tarefa_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/tasks/#{tarefa.id}")
      |> render(:show, tarefa: tarefa)
    end
  end


  def show(conn, %{"id" => id}) do
    tarefa = Tarefas.get_tarefa!(id)
    render(conn, :show, tarefa: tarefa)
  end

  def update(conn, %{"id" => id, "tarefa" => tarefa_params}) do
    tarefa = Tarefas.get_tarefa!(id)

    with {:ok, %Tarefa{} = tarefa} <- Tarefas.update_tarefa(tarefa, tarefa_params) do
      render(conn, :show, tarefa: tarefa)
    end
  end

  def delete(conn, %{"id" => id}) do
    tarefa = Tarefas.get_tarefa!(id)

    with {:ok, %Tarefa{}} <- Tarefas.delete_tarefa(tarefa) do
      send_resp(conn, :no_content, "")
    end
  end
end
