defmodule TarefaApi.Tarefas.Tarefa do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :description, :string
    field :title, :string
    field :is_completed, :boolean, default: false

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(tarefa, attrs) do
    tarefa
    |> cast(attrs, [:title, :description, :is_completed])
    |> validate_required([:title, :description, :is_completed])
  end
end
