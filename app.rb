require 'byebug'
require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/flash'
require_relative './lib/peep'


class ChitterApp < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    register Sinatra::Flash
    set :public_folder, Proc.new { File.join(root, 'static') }
  end

  enable :sessions, :methods_override

  get '/' do
    'Chitter Application'
  end

  get '/peeps/new' do
    erb :'peeps/new'
  end

  post '/peeps' do
    Peep.create(content: params[:peep])
    redirect '/peeps'
  end

  get '/peeps' do
    @peeps = Peep.all
    p @peeps
    erb :'peeps/index'
  end 

  run! if app_file == $0
end