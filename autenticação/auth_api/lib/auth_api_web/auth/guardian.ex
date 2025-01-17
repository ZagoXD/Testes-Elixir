defmodule AuthApiWeb.Auth.Guardian do
  use Guardian, otp_app: :auth_api

  alias AuthApi.Accounts

  def subject_for_token(%{id: id}, _claims) when is_integer(id) do
    {:ok, to_string(id)}
  end

  def subject_for_token(_, _claims) do
    {:error, :invalid_subject}
  end

  def resource_from_claims(%{"sub" => id}) do
    case Accounts.get_user(id) do
      nil -> {:error, :resource_not_found}
      user -> {:ok, user}
    end
  end
end
