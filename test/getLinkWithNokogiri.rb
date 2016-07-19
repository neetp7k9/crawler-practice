require "open-uri"
require 'open_uri_redirections'
require "nokogiri"

doc = Nokogiri::HTML(open("http://www.google.com"))
url = URI("http://www.google.com")
doc.css('a').each do |node|
  p url.merge node["href"]
end
