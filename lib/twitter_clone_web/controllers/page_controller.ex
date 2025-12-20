defmodule TwitterCloneWeb.PageController do
  use TwitterCloneWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
