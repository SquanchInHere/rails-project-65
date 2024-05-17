# frozen_string_literal: true

module ApplicationHelper
  def nav_link_to(name, path, options = {})
    options[:class].gsub!(/\blink-dark\b/, 'link-light active').strip if current_page?(path)
    link_to(name, path, options)
  end
end
