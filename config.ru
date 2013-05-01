require './app'

set :logging, false
set :environment, :production

run Sinatra::Application
