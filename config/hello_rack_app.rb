class HelloRackApp
  def call(env)
    [200, {'Content-Type' => 'text/plain'}, ['Hello, Rack!']]
  end
end