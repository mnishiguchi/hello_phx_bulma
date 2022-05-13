defmodule HelloPhxBulmaWeb.Components.Hero do
  use HelloPhxBulmaWeb, :surface_component

  prop color, :string, values!: ~w[
    danger
    info
    light
    dark
    success
    link
    primary
    warning
  ]

  prop size, :string, values!: ~w[
    small
    medium
    large
    halfheight
    fullheight
  ]

  slot default, required: true

  def render(assigns) do
    ~F"""
    <section class={"hero", "is-#{@color}": @color, "is-#{@size}": @size}>
      <div class="hero-body">
        <div class="container has-text-centered">
          <#slot />
        </div>
      </div>
    </section>
    """
  end
end
