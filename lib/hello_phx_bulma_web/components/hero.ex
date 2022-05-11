defmodule HelloPhxBulmaWeb.Components.Hero do
  @moduledoc """
  The hero
  """

  use Surface.Component

  @doc "The color"
  prop color, :string, values!: ~w[
    danger
    info
    light
    link
    primary
    warning
  ]

  slot default, required: true

  def render(assigns) do
    ~F"""
    <section class={"hero", "is-#{@color}": @color}>
      <div class="hero-body">
        <div class="container has-text-centered">
          <#slot />
        </div>
      </div>
    </section>
    """
  end
end
