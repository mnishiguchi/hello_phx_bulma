defmodule HelloPhxBulmaWeb.Components.Hero.ExampleColor do
  @moduledoc """
  Example using the `color` property.
  """

  use Surface.Catalogue.Example,
    subject: HelloPhxBulmaWeb.Components.Hero,
    height: "70rem",
    title: "Colors"

  alias HelloPhxBulmaWeb.Components.Hero
  alias SurfaceBulma.Title
  alias SurfaceBulma.SubTitle

  def render(assigns) do
    ~F"""
    <Hero color="light">
      <Title size="4" spaced><.title /></Title>
    </Hero>
    <Hero color="dark">
      <Title size="4" spaced><.title /></Title>
    </Hero>
    <Hero color="primary">
      <Title size="4" spaced><.title /></Title>
    </Hero>
    <Hero color="link">
      <Title size="4" spaced><.title /></Title>
    </Hero>
    <Hero color="info">
      <Title size="4" spaced><.title /></Title>
    </Hero>
    <Hero color="success">
      <Title size="4" spaced><.title /></Title>
    </Hero>
    <Hero color="warning">
      <Title size="4" spaced><.title /></Title>
    </Hero>
    <Hero color="danger">
      <Title size="4" spaced><.title /></Title>
    </Hero>
    """
  end

  defdelegate title(assigns), to: HelloPhxBulmaWeb.Components.Hero.Playground
end
