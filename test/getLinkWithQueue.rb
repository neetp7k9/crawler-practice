require "open-uri"
require 'open_uri_redirections'
require "nokogiri"

queue = [URI("http://www.google.com")]

page_num = 0
while queue.size > 0 do
  url = queue.shift.normalize
  doc = Nokogiri::HTML(open(url, :allow_redirections => :safe))
  page_num += 1
  doc.css('a').each do |node|
    next unless node["href"]
    p node["href"]
    p "#{page_num} => #{url.merge node["href"].strip}"
    queue.push url.merge node["href"].strip
  end
end
