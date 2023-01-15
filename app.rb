require 'sinatra'
require 'sinatra/reloader'
require_relative 'lib/database_connection'
require_relative 'lib/peep_repository'
require_relative 'lib/user_repository'

DatabaseConnection.connect

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

    get '/peeps' do
        repo = PeepRepository.new
        @user = UserRepository.new
        @peeps = repo.all
    return erb(:index)
    end

    get '/user/:user_id' do
      repo = PeepRepository.new
      user = UserRepository.new
      @peeps = repo.find_user_id(params[:user_id])
      @user_name = user.find(@peeps[0].user_id).name
 
      return erb(:peeps)
    end
 
    post '/users' do 
      if incorrect_users_parameters?
        status 400
        return ''
      end
      repo = UserRepository.new
      new_user = User.new
      new_user.email = params[:email]
      new_user.password = params[:password]
      new_user.name = params[:name]
      new_user.username = params[:username]
 
      repo.create(new_user)
 
      return ''
    end
 
    get '/users/new' do
      return erb(:new_user)
    end
 
    post '/peeps' do 
      if incorrect_peeps_parameters?
        status 400
        return ''
      end
      repo = PeepRepository.new
      new_peep = Peep.new
      new_peep.message = params[:message]
      new_peep.time = params[:time]
      new_peep.user_id = params[:user_id]
 
      repo.create(new_peep)
 
      return ''
    end
 
    get '/peeps/new' do
      return erb(:new_peep)
    end
 
end

