defmodule AuthApi.Accounts do
  import Ecto.Query
  alias AuthApi.Repo
  alias AuthApi.Accounts.User
  alias Bcrypt

  def register_user(attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def authenticate_user(username, password) do
    case Repo.get_by(User, username: username) do
      %User{} = user ->
        if Bcrypt.verify_pass(password, user.password_hash) do
          {:ok, user} # Retorne o usuário completo aqui
        else
          {:error, "Invalid credentials"}
        end

      nil -> {:error, "Invalid credentials"}
    end
  end

end
