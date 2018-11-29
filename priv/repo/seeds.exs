# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     LFA.Repo.insert!(%LFA.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

LFA.Repo.insert!(%LFA.Users.User{slack_id: "UDU6UNFRP", name: "Marcus"})
LFA.Repo.insert!(%LFA.Users.User{slack_id: "UDUQPESM8", name: "Camden"})
LFA.Repo.insert!(%LFA.Users.User{slack_id: "UDW6VM8F8", name: "John"})
LFA.Repo.insert!(%LFA.Users.User{slack_id: "UDV1XR66R", name: "Kacper"})
LFA.Repo.insert!(%LFA.Users.User{slack_id: "UDW5MDGV8", name: "Ryan"})
LFA.Repo.insert!(%LFA.Users.User{slack_id: "UDV1N4HN1", name: "Yuvi"})
LFA.Repo.insert!(%LFA.Users.User{slack_id: "UDW7TKBC6", name: "Chris"})
