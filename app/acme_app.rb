module Acme
  class App
    def initialize
      @filenames = [ '', '.html', 'index.html', '/index.html' ]
      @rack_static = ::Rack::Static.new(
        lambda { [404, {}, []] }, {
          :root => File.expand_path('../../public', __FILE__),
          :urls => %w[/]
        })
    end
    def call(env)
      request_path = env['PATH_INFO']      
      # static files
      @filenames.each do |path|
        response = @rack_static.call(env.merge({'PATH_INFO' => request_path + path}))
        return response unless [ 404, 405 ].include?(response[0])
      end
      # api
      Acme::API.call(env)
    end
  end
end


