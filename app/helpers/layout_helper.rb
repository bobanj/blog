# These helper methods can be called in your template to set variables to be used in the layout
# This module should be included in all views globally,
# to do so you may need to add this line to your ApplicationController
#   helper :layout
module LayoutHelper
  def title(page_title)
    content_for(:title) { h(page_title.to_s) }
  end

  def keywords(page_keywords)
    content_for(:keywords) { page_keywords } unless page_keywords.blank?
  end

  def description(page_description)
      content_for(:description) {
        sanitize(page_description.gsub(/<code[^<]*<\/code>/, ""), :tags => %w(), :attributes => %w()).gsub(/[\r\n?]/, " ").squeeze(" ").gsub(/\"/, "'")[0..250].strip
      } unless page_description.blank?
  end

  def stylesheet(*args)
    content_for(:mod_style) { stylesheet_link_tag(*args) }
  end

  def javascript(*args)
    content_for(:mod_javascript) { javascript_include_tag(*args) }
  end

  def no_robots
    content_for :robots do
      tag(:meta, :content => 'noarchive, noindex, nofollow', :name => "robots")
    end
  end
end