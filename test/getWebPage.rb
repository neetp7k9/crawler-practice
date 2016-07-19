require "open-uri"
require 'open_uri_redirections'

f = open('http://5xruby.tw', :allow_redirections => :safe)
p f.read
