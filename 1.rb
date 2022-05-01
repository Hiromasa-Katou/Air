require('sinatra')
# set :environment, :production
get('/') do
  "This will be our home page. '/' is always the root route in a Sinatra application."
end

not_found do
  halt 404
end