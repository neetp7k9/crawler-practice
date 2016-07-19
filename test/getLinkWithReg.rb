require "open-uri"
require 'open_uri_redirections'

f = open("http://www.google.com")
body = f.read
body.scan(/href="([^"]*)"/) do |match|
  p URI.join "http://www.google.com", match[0]
end
