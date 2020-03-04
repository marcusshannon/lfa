defmodule LFAWeb.ComponentHelpers do
  def combine_classes(classes_1, classes_2) when is_nil(classes_2) do
    "#{classes_1}"
  end

  def combine_classes(classes_1, classes_2) do
    "#{classes_1} #{classes_2}"
  end

  def component(template) do
    LFAWeb.ComponentView.render(template, [])
  end

  def component(template, assigns) do
    LFAWeb.ComponentView.render(template, assigns)
  end

  def component(template, assigns, do: block) do
    LFAWeb.ComponentView.render(template, Keyword.merge(assigns, [do: block]))
  end
end
