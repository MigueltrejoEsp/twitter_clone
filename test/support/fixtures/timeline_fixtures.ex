defmodule TwitterClone.TimelineFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TwitterClone.Timeline` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        body: "some body"
      })

    {:ok, post} = TwitterClone.Timeline.create_post(scope, attrs)
    post
  end
end
