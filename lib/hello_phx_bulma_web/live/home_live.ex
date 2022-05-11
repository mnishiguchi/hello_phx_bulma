defmodule HelloPhxBulmaWeb.HomeLive do
  use HelloPhxBulmaWeb, :surface_view

  alias HelloPhxBulmaWeb.Components.Hero
  alias SurfaceBulma.Title
  alias SurfaceBulma.SubTitle

  def render(assigns) do
    ~F"""
    <Hero color="light">
      <Title size="2" spaced>我々ハ錬金術師我ガ友ヨ</Title>
      <SubTitle size="5">
        いろはにほへとちりぬるを<br>
        わかよたれそつねならむ<br>
        うゐのおくやまけふこえて<br>
        あさきゆめみしゑひもせすん
      </SubTitle>
      <a href="https://autoracex.connpass.com" class="button is-primary">Get Started</a>
    </Hero>
    """
  end
end
