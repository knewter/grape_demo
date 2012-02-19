require File.expand_path('../config/environment', __FILE__)

=begin
use Rack::TryStatic,
  :root => File.expand_path('../public', __FILE__),
  :urls => %w[/],
  :try => ['.html', 'index.html', '/index.html']
=end
 
run Acme::API
