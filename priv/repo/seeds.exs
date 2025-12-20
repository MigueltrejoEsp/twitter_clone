# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TwitterClone.Repo.insert!(%TwitterClone.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Code.require_file("accounts_fixtures.ex", "test/support/fixtures")

user =
  TwitterClone.AccountsFixtures.user_fixture(%{
    email: "test@example.com",
    password: "my_secret_password_123"
  })

dbg(user)
