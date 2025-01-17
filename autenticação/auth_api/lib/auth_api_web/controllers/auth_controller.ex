defmodule AuthApiWeb.AuthController do
  use AuthApiWeb, :controller
  alias AuthApi.Accounts
  alias AuthApiWeb.Auth.Guardian

  def register(conn, %{"username" => username, "password" => password}) do
    case Accounts.register_user(%{username: username, password: password}) do
      {:ok, _user} ->
        json(conn, %{message: "User registered successfully"})

      {:error, changeset} ->
        conn
        |> put_status(:conflict)
        |> json(%{error: "User already exists", details: changeset.errors})
    end
  end

  def login(conn, %{"username" => username, "password" => password}) do
    case Accounts.authenticate_user(username, password) do
      {:ok, user} ->
        {:ok, token, _claims} = AuthApiWeb.Auth.Guardian.encode_and_sign(user)
        json(conn, %{message: "Login successful", token: token})

      {:error, error} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: error})
    end
  end

end
