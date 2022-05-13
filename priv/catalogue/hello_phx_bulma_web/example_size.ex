defmodule HelloPhxBulmaWeb.Components.Hero.ExampleSize do
  @moduledoc """
  Example using the `size` property.
  """

  use Surface.Catalogue.Example,
    subject: HelloPhxBulmaWeb.Components.Hero,
    height: "20rem",
    title: "Sizes"

  alias HelloPhxBulmaWeb.Components.Hero
  alias SurfaceBulma.Title
  alias SurfaceBulma.SubTitle

  def render(assigns) do
    ~F"""
    <Hero color="light" size="small">
      <Title size="4" spaced><.title /></Title>
    </Hero>
    <Hero color="info" size="medium">
      <Title size="4" spaced><.title /></Title>
    </Hero>
    """
  end

  defdelegate title(assigns), to: HelloPhxBulmaWeb.Components.Hero.Playground
end
