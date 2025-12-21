defmodule TwitterClone.TimelineTest do
  use TwitterClone.DataCase

  alias TwitterClone.Timeline

  describe "posts" do
    alias TwitterClone.Timeline.Post

    import TwitterClone.AccountsFixtures, only: [user_scope_fixture: 0]
    import TwitterClone.TimelineFixtures

    @invalid_attrs %{body: nil}

    test "list_posts/1 returns all scoped posts" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      post = post_fixture(scope)
      other_post = post_fixture(other_scope)
      assert Timeline.list_posts(scope) == [post]
      assert Timeline.list_posts(other_scope) == [other_post]
    end

    test "get_post!/2 returns the post with given id" do
      scope = user_scope_fixture()
      post = post_fixture(scope)
      other_scope = user_scope_fixture()
      assert Timeline.get_post!(scope, post.id) == post
      assert_raise Ecto.NoResultsError, fn -> Timeline.get_post!(other_scope, post.id) end
    end

    test "create_post/2 with valid data creates a post" do
      valid_attrs = %{body: "some body"}
      scope = user_scope_fixture()

      assert {:ok, %Post{} = post} = Timeline.create_post(scope, valid_attrs)
      assert post.body == "some body"
      assert post.user_id == scope.user.id
    end

    test "create_post/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Timeline.create_post(scope, @invalid_attrs)
    end

    test "update_post/3 with valid data updates the post" do
      scope = user_scope_fixture()
      post = post_fixture(scope)
      update_attrs = %{body: "some updated body"}

      assert {:ok, %Post{} = post} = Timeline.update_post(scope, post, update_attrs)
      assert post.body == "some updated body"
    end

    test "update_post/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      post = post_fixture(scope)

      assert_raise MatchError, fn ->
        Timeline.update_post(other_scope, post, %{})
      end
    end

    test "update_post/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      post = post_fixture(scope)
      assert {:error, %Ecto.Changeset{}} = Timeline.update_post(scope, post, @invalid_attrs)
      assert post == Timeline.get_post!(scope, post.id)
    end

    test "delete_post/2 deletes the post" do
      scope = user_scope_fixture()
      post = post_fixture(scope)
      assert {:ok, %Post{}} = Timeline.delete_post(scope, post)
      assert_raise Ecto.NoResultsError, fn -> Timeline.get_post!(scope, post.id) end
    end

    test "delete_post/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      post = post_fixture(scope)
      assert_raise MatchError, fn -> Timeline.delete_post(other_scope, post) end
    end

    test "change_post/2 returns a post changeset" do
      scope = user_scope_fixture()
      post = post_fixture(scope)
      assert %Ecto.Changeset{} = Timeline.change_post(scope, post)
    end
  end
end
