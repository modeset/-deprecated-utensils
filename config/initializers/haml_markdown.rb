
module Haml::Filters::Markdown
  include Haml::Filters::Base
  lazy_require "redcarpet"

  def render(text)
    Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(),
                                        :autolink => true,
                                        :no_intra_emphasis => true,
                                        :tables => true,
                                        :fenced_code_blocks => true,
                                        :lax_html_blocks => true,
                                        :strikethrough => true,
                                        :superscript => true,
                                        :space_after_headers => true
                                       ).render(text)
  end
end

