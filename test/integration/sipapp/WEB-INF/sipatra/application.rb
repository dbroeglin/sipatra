invite /.*/ do
  puts "#{message.method} #{message.requestURI}"
  $stdout.flush
  proxy "sip:#{message.requestURI.user}@127.0.0.1:5090"
end

register do
  puts "#{message.method} #{message.requestURI}"
  $stdout.flush
  proxy "sip:#{message.requestURI.user}@127.0.100.1:5060"
end

request do
  puts "#{message.method} #{message.requestURI} [default]"
  $stdout.flush
end

#ack do
#  puts "#{message.method} #{message.requestURI}"
#  proxy "sip:toto@127.0.2.1:5062"
#end

response do
  puts "RESPONSE: #{message.status} #{message.request.requestURI}"
  $stdout.flush
end
