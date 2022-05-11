defmodule HelloPhxBulmaWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, views, channels and so on.

  This can be used in your application as:

      use HelloPhxBulmaWeb, :controller
      use HelloPhxBulmaWeb, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """

  def controller do
    quote do
      use Phoenix.Controller, namespace: HelloPhxBulmaWeb

      import Plug.Conn
      import HelloPhxBulmaWeb.Gettext
      alias HelloPhxBulmaWeb.Router.Helpers, as: Routes
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/hello_phx_bulma_web/templates",
        namespace: HelloPhxBulmaWeb

      # Import convenience functions from controllers
      import Phoenix.Controller,
        only: [get_flash: 1, get_flash: 2, view_module: 1, view_template: 1]

      # Include shared imports and aliases for views
      unquote(view_helpers())
      import Surface
    end
  end

  def live_view do
    quote do
      use Phoenix.LiveView,
        layout: {HelloPhxBulmaWeb.LayoutView, "live.html"}

      unquote(view_helpers())
    end
  end

  def live_component do
    quote do
      use Phoenix.LiveComponent

      unquote(view_helpers())
    end
  end

  def component do
    quote do
      use Phoenix.Component

      unquote(view_helpers())
    end
  end

  def surface_view do
    quote do
      use Surface.LiveView,
        layout: {HelloPhxBulmaWeb.LayoutView, "live.html"}

      unquote(view_helpers())
      unquote(surface_helpers())
    end
  end

  def surface_live_component do
    quote do
      use Surface.LiveComponent

      unquote(view_helpers())
      unquote(surface_helpers())
    end
  end

  def surface_component do
    quote do
      use Surface.Component

      unquote(view_helpers())
      unquote(surface_helpers())
    end
  end

  def router do
    quote do
      use Phoenix.Router

      import Plug.Conn
      import Phoenix.Controller
      import Phoenix.LiveView.Router
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import HelloPhxBulmaWeb.Gettext
    end
  end

  defp view_helpers do
    quote do
      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      # Import LiveView and .heex helpers (live_render, live_patch, <.form>, etc)
      import Phoenix.LiveView.Helpers

      # Import basic rendering functionality (render, render_layout, etc)
      import Phoenix.View

      import HelloPhxBulmaWeb.BulmaInputHelpers
      import HelloPhxBulmaWeb.ErrorHelpers
      import HelloPhxBulmaWeb.Gettext
      alias HelloPhxBulmaWeb.Router.Helpers, as: Routes
    end
  end

  defp surface_helpers do
    quote do
      # https://surface-ui.org/builtincomponents
      alias Surface.Components.Link
      alias Surface.Components.LivePatch
      alias Surface.Components.LiveRedirect
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
