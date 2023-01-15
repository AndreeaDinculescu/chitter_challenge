require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  before(:each) do
    reset_peeps_table
    reset_users_table
  end

  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context 'GET /peeps' do
    it 'returns all peeps' do
        response = get('/')

        expect(response.status).to eq(200)
        expect(response.body).to include('Welcome to Chitter!')
        expect(response.body).to include('Message: This is my first comment')
        expect(response.body).to include('Username: <a href="/user/1">Andreea</a>')
    end
  end
 
  context 'GET /user/:user_id' do
    it 'should return all peeps from user Andreea ' do
      response = get('/user/1')

      expect(response.status).to eq(200)
      expect(response.body).to include("Andreea's Peeps")
      expect(response.body).to include('Message: This is my first comment')
      expect(response.body).to include('Message: This is my second comment')
    end
  end

  context 'POST /users' do
    it 'should validate user parameters' do
      response = post('/users', incorrect_email_address: 'andre@mail.com', incorrect_username: 'any')

      expect(response.status).to eq(400)
    end
  end

  context 'POST /peeps' do
    it 'should validate peep parameters' do
      response = post('/peeps', incorrect_name: 'Name', incorrect_user_id: 244)

      expect(response.status).to eq(400)
    end
  end

  context 'GET /users/new' do
    it 'should return the form to add a new user' do
      response = get('/users/new')

      expect(response.status).to eq(200)
      expect(response.body).to include('<form method="POST" action="/users">')
      expect(response.body).to include('<input type="text" name="name" />')
      expect(response.body).to include('<input type="text" name="email" />')
      expect(response.body).to include('<input type="text" name="username" />')
      expect(response.body).to include('<input type="text" name="password" />')
    end
  end

  context 'GET /peeps/new' do
    it 'should return the form to add a new peep' do
      response = get('/peeps/new')

      expect(response.status).to eq(200)
      expect(response.body).to include('<form method="POST" action="/peeps">')
      expect(response.body).to include('<input type="text" name="message" />')
      expect(response.body).to include('<input type="text" name="time" />')
      expect(response.body).to include('<input type="text" name="user_id" />')
    end
  end
end