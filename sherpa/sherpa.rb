
require 'redcarpet'
require 'mustache'
require 'haml'

module Sherpa
  class Builder

    def initialize
      @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(),
                                          :autolink => true,
                                          :no_intra_emphasis => true,
                                          :tables => true,
                                          :fenced_code_blocks => true,
                                          :lax_html_blocks => true,
                                          :strikethrough => true,
                                          :superscript => true,
                                          :space_after_headers => true
                                         )
      @stache_layout = File.read(File.join("./sherpa/", "layout.mustache"))

      # manifest = Dir["./app/assets/**/*.md"]
      manifest = Dir["./app/assets/utensils/**/*.md"]
      aside = get_navigation(manifest)
      lines = cat_manifest(manifest)
      marked = carpet_bag(lines)
      render_layout(marked, aside)
    end

    def get_navigation(manifest)
      nav = ""
      manifest.each do |file|
        path = File.expand_path(file)
        id = File.dirname(path).split('/').last
        title = id.gsub(/_|-/, " ").capitalize
        nav += "<li><a href='##{id}'>#{title}</a></li>\n"
      end
      nav
    end

    def cat_manifest(manifest)
      lines = ""

      manifest.each do |file|
        file_with_path = File.expand_path(file)
        in_usage = false
        in_code_block = false
        is_haml = nil
        markup_block = ""
        code_block = ""

        lines += '<section class="sherpa-section sherpa-clearfix">'

        File.new(file_with_path, "r").each do |line|

          if !!(line =~ /^`{3}/)
            pre_block = !pre_block
          end

          if !!(line =~ /^#*\sUsage\sExa/)
            in_usage = true
          elsif !!(line =~ /^#/)
            in_usage = false
            lines += line
          elsif !in_code_block && !in_usage
            lines += line
          end

          # Do some special rendering on Usage Example blocks
          if in_usage
            # exit the code block
            if !!(line =~ /^`{3}\s/) && in_code_block
              in_code_block = false
              lines += "\n"

              # render the showcase block before the code snippet
              if markup_block != ""
                lines += '<div class="sherpa-showcase sherpa-clearfix">'
                # convert us over to html if we are haml
                if is_haml
                  lines += convert_to_html(markup_block)
                else
                  lines += markup_block
                end
                lines += "</div>\n\n"
                lines += code_block
                # add some backticks to end the pre block
                lines += line
                markup_block = ""
                code_block = ""
              end
            # start the code block rendering
            elsif !!(line =~ /^```h(a|t)ml/)
              is_haml = !!(line =~ /^```haml/)
              markup_block = ""
              code_block = line
              in_code_block = true
            elsif in_code_block
              markup_block += line
              code_block += line
            else
              lines += line unless !!(line =~ /^#*\sUsage/)
            end
          end
        end
        lines += '</section>'
      end
      lines
    end

    def convert_to_html(block)
      Haml::Engine.new(block).render.gsub(/^\s*/, '')
    end

    def carpet_bag(lines)
      @markdown.render(lines)
    end

    def render_layout(marked, aside)
      layout = Mustache.render(@stache_layout, layout: marked, aside: aside)
      File.open("./public/docs/index.html", "w") do |file|
        file.write(layout)
      end
    end

  end
end

builder = Sherpa::Builder.new()

