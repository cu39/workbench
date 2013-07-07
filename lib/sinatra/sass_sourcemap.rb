require 'sinatra/base'
require 'json'

module Sinatra
  module SassSourcemap
    def sass_map_header(template, opts = {}, locals = {})
      sourcemap_path_info = request.path_info.sub(/\.css$/, '.sassmap')
      response['X-SourceMap'] = sourcemap_path_info
      response['SourceMap'] = sourcemap_path_info
    end

    def sass_with_map(template, opts = {}, locals = {})
      content_type :css
      css, srcmap = __sass_render(template, opts, locals)
      @output = css
    end

    def sass_map(template, opts = {}, locals = {})
      content_type :json
      css, srcmap = __sass_render(template, opts, locals)
      css_path_info = request.path_info.sub(/\.sassmap$/, '.css')
      json_opts = { css_path: css_path_info, sourcemap_path: request.path_info }
      json = JSON srcmap.to_json(json_opts)
      json['sources'].each do |src_path| src_path.sub!(/^\.\./, 'file://') end
      @output = json.to_json
    end

    private

    def __sass_render(template, opts = {}, locals = {})
      css_path_info = sassmap_path_info = request.path_info
      css_path_info.sub!(/\.sassmap$/, '.css')
      sassmap_path_info.sub!(/\.css$/, '.sassmap')
      sass_path = File.join(settings.views, template.to_s + '.sass')

      opts = __sass_merged_options(filename: sass_path)
      engine = ::Sass::Engine.new(File.read(sass_path), opts)
      engine.render_with_sourcemap(sassmap_path_info)
    end

    def __sass_merged_options(opts = {})
      return opts unless settings.respond_to?(:sass)
      return opts if settings.sass.nil?
      opts.merge(settings.sass)
    end
  end

  helpers SassSourcemap
end
