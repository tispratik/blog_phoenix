defmodule Blog.Post do
  use Blog.Web, :model
  import Ecto.Query

  schema "posts" do
    field :title, :string
    field :body, :string

    has_many :comments, Blog.Comment

    timestamps
  end

  @required_fields ~w(title body)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
  
  def count_comments(query) do
    from post in query,
      group_by: post.id,
      left_join: comment in assoc(post, :comments),
      select: {post, count(comment.id)}      
  end
end
