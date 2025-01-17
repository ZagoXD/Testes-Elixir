defmodule TarefaApi.TarefasTest do
  use TarefaApi.DataCase

  alias TarefaApi.Tarefas

  describe "tasks" do
    alias TarefaApi.Tarefas.Tarefa

    import TarefaApi.TarefasFixtures

    @invalid_attrs %{description: nil, title: nil, is_completed: nil}

    test "list_tasks/0 returns all tasks" do
      tarefa = tarefa_fixture()
      assert Tarefas.list_tasks() == [tarefa]
    end

    test "get_tarefa!/1 returns the tarefa with given id" do
      tarefa = tarefa_fixture()
      assert Tarefas.get_tarefa!(tarefa.id) == tarefa
    end

    test "create_tarefa/1 with valid data creates a tarefa" do
      valid_attrs = %{description: "some description", title: "some title", is_completed: true}

      assert {:ok, %Tarefa{} = tarefa} = Tarefas.create_tarefa(valid_attrs)
      assert tarefa.description == "some description"
      assert tarefa.title == "some title"
      assert tarefa.is_completed == true
    end

    test "create_tarefa/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tarefas.create_tarefa(@invalid_attrs)
    end

    test "update_tarefa/2 with valid data updates the tarefa" do
      tarefa = tarefa_fixture()
      update_attrs = %{description: "some updated description", title: "some updated title", is_completed: false}

      assert {:ok, %Tarefa{} = tarefa} = Tarefas.update_tarefa(tarefa, update_attrs)
      assert tarefa.description == "some updated description"
      assert tarefa.title == "some updated title"
      assert tarefa.is_completed == false
    end

    test "update_tarefa/2 with invalid data returns error changeset" do
      tarefa = tarefa_fixture()
      assert {:error, %Ecto.Changeset{}} = Tarefas.update_tarefa(tarefa, @invalid_attrs)
      assert tarefa == Tarefas.get_tarefa!(tarefa.id)
    end

    test "delete_tarefa/1 deletes the tarefa" do
      tarefa = tarefa_fixture()
      assert {:ok, %Tarefa{}} = Tarefas.delete_tarefa(tarefa)
      assert_raise Ecto.NoResultsError, fn -> Tarefas.get_tarefa!(tarefa.id) end
    end

    test "change_tarefa/1 returns a tarefa changeset" do
      tarefa = tarefa_fixture()
      assert %Ecto.Changeset{} = Tarefas.change_tarefa(tarefa)
    end
  end
end
