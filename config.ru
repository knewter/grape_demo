require File.expand_path('../config/environment', __FILE__)

class App

  def initialize(options)
    @try = ['', *options.delete(:try)]
    @static = ::Rack::Static.new(
      lambda { [404, {}, []] }, 
      options)
  end
    
  def call(env)
    orig_path = env['PATH_INFO']
    # there's probably a better way to do this
    if orig_path.starts_with?('/api/')
      Acme::API.call(env)
    else
      found = nil
      @try.each do |path|
        resp = @static.call(env.merge!({'PATH_INFO' => orig_path + path}))
        break if 404 != resp[0] && found = resp
      end
      found or [404, {}, []]
    end
  end
  
end

run App.new({
  :root => File.expand_path('../public', __FILE__),
  :urls => %w[/],
  :try => ['.html', 'index.html', '/index.html']
  })


