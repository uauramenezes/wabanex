defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.User
  alias Wabanex.Users.Create

  describe "user query" do
    test "when a valid id is given, returns the user", %{conn: conn} do
      params = %{name: "Banana", email: "banana@banana.com", password: "123456789"}

      {:ok, %User{id: user_id}} = Create.call(params)

      query = """
        {
          getUser(id: "#{user_id}"){
            name
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      expected_response = %{
        "data" => %{
          "getUser" => %{
            "email" => "banana@banana.com",
            "name" => "Banana"
          }
        }
      }

      assert response == expected_response
    end
  end

  describe "users mutation" do
    test "When all params are valid, creates an user", %{conn: conn} do
      mutation = """
        mutation {
          createUser(input: {
            name: "Banana", email: "banana@banana.com", password: "123456789"
          }) {
            id
            name
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)

      assert %{"data" => %{"createUser" => %{"id" => _id, "name" => "Banana"}}} = response
    end
  end
end
