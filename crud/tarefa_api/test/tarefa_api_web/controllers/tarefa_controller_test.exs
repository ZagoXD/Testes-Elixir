defmodule TarefaApiWeb.TarefaControllerTest do
  use TarefaApiWeb.ConnCase

  import TarefaApi.TarefasFixtures

  alias TarefaApi.Tarefas.Tarefa

  @create_attrs %{
    description: "some description",
    title: "some title",
    is_completed: true
  }
  @update_attrs %{
    description: "some updated description",
    title: "some updated title",
    is_completed: false
  }
  @invalid_attrs %{description: nil, title: nil, is_completed: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all tasks", %{conn: conn} do
      conn = get(conn, ~p"/api/tasks")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create tarefa" do
    test "renders tarefa when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/tasks", tarefa: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/tasks/#{id}")

      assert %{
               "id" => ^id,
               "description" => "some description",
               "is_completed" => true,
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/tasks", tarefa: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update tarefa" do
    setup [:create_tarefa]

    test "renders tarefa when data is valid", %{conn: conn, tarefa: %Tarefa{id: id} = tarefa} do
      conn = put(conn, ~p"/api/tasks/#{tarefa}", tarefa: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/tasks/#{id}")

      assert %{
               "id" => ^id,
               "description" => "some updated description",
               "is_completed" => false,
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, tarefa: tarefa} do
      conn = put(conn, ~p"/api/tasks/#{tarefa}", tarefa: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete tarefa" do
    setup [:create_tarefa]

    test "deletes chosen tarefa", %{conn: conn, tarefa: tarefa} do
      conn = delete(conn, ~p"/api/tasks/#{tarefa}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/tasks/#{tarefa}")
      end
    end
  end

  defp create_tarefa(_) do
    tarefa = tarefa_fixture()
    %{tarefa: tarefa}
  end
end
