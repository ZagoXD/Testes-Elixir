defmodule AuthApi.Repo.Migrations.FillPasswordHash do
  use Ecto.Migration

  def up do
    execute("""
    UPDATE users
    SET password_hash = 'placeholder_hash'
    WHERE password_hash IS NULL
    """)
  end

  def down do
    execute("""
    UPDATE users
    SET password_hash = NULL
    """)
  end
end
