require "open-uri"
require 'open_uri_redirections'
require "nokogiri"
require 'redis'

redis = Redis.new
redis.rpush :page_queue, [URI("http://www.google.com")]
page_num = 0
loop do
  url = URI(redis.lpop :page_queue).normalize
  doc = Nokogiri::HTML(open(url, :allow_redirections => :safe))
  redis.set "PAGE:#{url}#", doc
  page_num += 1
  doc.css('a').each do |node|
    next unless node["href"]
    p node["href"]
    if node["href"] =~ URI::regexp 
      p "#{page_num} => #{url.merge(node['href'].strip)}"
      redis.rpush :page_queue, url.merge(node['href'].strip)
    else
      redis.rpush :error_uri, node["href"]
    end
  end
end
