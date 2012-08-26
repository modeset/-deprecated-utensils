
require 'redcarpet'
require 'mustache'
require 'haml'

# - Make markup cleaner
# - Make it super sexy looking
# - Write the usage from the markup files into each of the readmes
# - Add pygments

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
      @stache_layout = File.read(File.join("./bin", "layout.mustache"))

      manifest = Dir["./app/assets/**/*.md"]
      lines = cat_manifest(manifest)
      marked = carpet_bag(lines)
      render_layout(marked)
    end

    def cat_manifest(manifest)
      lines = ""
      in_usage = false
      haml_block = ""
      in_haml_block = false

      manifest.each do |file|
        file_with_path = File.expand_path(file)
        lines += '<section class="sherpa-section sherpa-clearfix">'

        File.new(file_with_path, "r").each do |line|
          lines += line

          if !!(line =~ /^Usage|^#*\sUsage/)
            in_usage = true
          end

          if in_usage
            if !!(line =~ /^`{3}\s/)
              in_usage = false
              in_haml_block = false

              if haml_block != ""
                lines += '<div class="sherpa-showcase sherpa-clearfix">'
                lines += convert_to_html(haml_block)
                lines += "</div>"
                haml_block = ""
              end

            elsif !!(line =~ /^```h(a|t)ml/)
              haml_block = ""
              in_haml_block = true
            elsif (in_haml_block)
              haml_block += line
            end

          end

        end
        lines += '</section>'
      end

      lines
    end

    def convert_to_html(block)
      Haml::Engine.new(block).render
    end

    def carpet_bag(lines)
      @markdown.render(lines)
    end

    def render_layout(marked)
      layout = Mustache.render(@stache_layout, layout: marked)
      File.open("./public/docs/index.html", "w") do |file|
        file.write(layout)
      end
    end

  end
end

builder = Sherpa::Builder.new()

