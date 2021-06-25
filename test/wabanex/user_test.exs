defmodule Wabanex.UserTest do
  use Wabanex.DataCase, async: true

  alias Wabanex.User

  describe "changeset/1" do
    test "When all params are valid, return a valid changeset" do
      params = %{name: "Banana", email: "banana@banana.com", password: "1234567"}

      response = User.changeset(params)

      assert %Ecto.Changeset{
               valid?: true,
               changes: %{email: "banana@banana.com", name: "Banana", password: "1234567"},
               errors: []
             } = response
    end

    test "When there are invalid params, return an invalid changeset" do
      params = %{email: "banana@banana.com", password: "1"}

      response = User.changeset(params)

      expeted_response = %{
        name: ["can't be blank"],
        password: ["should be at least 6 character(s)"]
      }

      assert errors_on(response) == expeted_response
    end
  end
end
