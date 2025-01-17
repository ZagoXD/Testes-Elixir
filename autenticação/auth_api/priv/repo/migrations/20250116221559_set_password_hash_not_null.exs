defmodule AuthApi.Repo.Migrations.SetPasswordHashNotNull do
  use Ecto.Migration

  def change do
    alter table(:users) do
      modify :password_hash, :string, null: false
    end
  end
end
