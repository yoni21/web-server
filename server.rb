require 'socket'                                    # Require socket from Ruby Standard Library (stdlib)

host = 'localhost'
port = 2000

server = TCPServer.open(host, port)                 # Socket to listen to defined host and port
puts "Server started on #{host}:#{port} ..."        # Output to stdout that server started

loop do                                             # Server runs forever
  client = server.accept                            # Wait for a client to connect. Accept returns a TCPSocket

  lines = []
  while (line = client.gets) && !line.chomp.empty?  # Read the request and collect it until it's empty
    lines << line.chomp
  end
  puts lines

                                         # Output the full request to stdout

#3
  filename = lines[0].gsub(/GET \//, '').gsub(/\ HTTP.*/, '')

  if File.exists?(filename)
  response_body = File.read(filename)
  success_header = []
  success_header << "HTTP/1.1 200 OK"
  success_header << "Content-Type: text/html" # should reflect the appropriate content type (HTML, CSS, text, etc)
  success_header << "Content-Length: #{response_body.length}" # should be the actual size of the response body
  success_header << "Connection: close"
  header = success_header.join("\r\n")

  response = [success_header, response_body].join("\r\n\r\n")
else
  response_body = "File Not Found\n" # need to indicate end of the string with \n
  not_found_header = []
  not_found_header << "HTTP/1.1 200 OK"
  not_found_header << "Content-Type: text/html" # should reflect the appropriate content type (HTML, CSS, text, etc)
  not_found_header << "Content-Length: #{response_body.length}" # should be the actual size of the response body
  not_found_header << "Connection: close"
  header = not_found_header.join("\r\n")
  #5
  response = [not_found_header, response_body].join("\r\n\r\n")

end


  client.puts(response)                       # Output the current time to the client
  client.close                                      # Disconnect from the client
end
