# middleware to add custom header X-App-Name to the headers
class AppName
  def initialize(app, app_name)
    @app = app
    @app_name = app_name
  end

  def call(env)
    puts "(env) --> #{env}" # environment for the HTTP request
    puts "app.call(env) --> #{@app.call(env)}" # call method is part of Rack interface - used to handle HTTP request
    # Ex.: [304, {"x-frame-options"=>"SAMEORIGIN", "x-xss-protection"=>"0", "x-content-type-options"=>"nosniff", "..., "last-modified"=>"....}, []]
    status, headers, response = @app.call(env) # shortcut to assign the 3 elements of the array to the indicated variable names
    puts "headers --> #{headers}"
    # {"x-frame-options"=>"SAMEORIGIN", "x-xss-protection"=>"0", "x-content-type-options"=>"nosniff", "..., "last-modified"=>"....}
    headers.merge!({ "X-App-Name" => "#{@app_name}" }) # change header in place
    [ status, headers, response ]
  end
end

# load AppName - added to config/application.rb (config.middleware.use AppName)
