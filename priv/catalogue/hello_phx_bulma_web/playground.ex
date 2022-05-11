defmodule HelloPhxBulmaWeb.Components.Hero.Playground do
  use Surface.Catalogue.Playground,
    subject: HelloPhxBulmaWeb.Components.Hero,
    height: "20rem",
    body: [style: "padding: 1.5rem;"]

    alias HelloPhxBulmaWeb.Components.Hero
    alias SurfaceBulma.Title
    alias SurfaceBulma.SubTitle

  data props, :map, default: %{
    color: "info"
  }

  def render(assigns) do
    ~F"""
    <Hero {...@props} >
      <Title size="4" spaced><.title /></Title>
      <SubTitle size="5"><.subtitle /></SubTitle>
    </Hero>
    """
  end

  def title(assigns) do
    ~H"""
    我々ハ錬金術師我ガ友ヨ
    """
  end

  def subtitle(assigns) do
    ~H"""
    いろはにほへとちりぬるを<br>
    わかよたれそつねならむ<br>
    うゐのおくやまけふこえて<br>
    あさきゆめみしゑひもせすん
    """
  end
end
