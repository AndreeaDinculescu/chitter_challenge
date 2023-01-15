require 'user'
require 'user_repository'

describe UserRepository do
def reset_users_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'chitter_challenge_test' })
    connection.exec(seed_sql)
end

before(:each) do
    reset_users_table
end

context 'all method' do
    it 'finds all users' do
        repo = UserRepository.new
        
        users = repo.all

        expect(users.length).to eq(2)
        expect(user[0].id).to eq('1')
        expect(user[0].name).to eq('Andreea')
        expect(user[0].email_address).to eq('andreea@mail.com')
        expect(user[0].username).to eq('andre')
        expect(user[0].password).to eq('ABC123def$')

        expect(user[1].id).to eq('2')
        expect(user[1].name).to eq('Adrian')
        expect(user[1].email_address).to eq('adrian@mail.com')
        expect(user[1].username).to eq('adi')
        expect(user[1].password).to eq('$fed321CBA')
    end
end

context 'find(id)' do
    it 'finds a single user' do
        repo = UserRepository.new
        user = repo.find(1)
        expect(user.id).to eq(1)
        expect(user.name).to eq('Andreea')
        expect(user.email_address).to eq('andreea@mail.com')
        expect(user.username).to eq('andre')
    end
end

context "create method" do
    it "create a new user" do
      repo = UserRepository.new

      user = User.new
      user.name = 'Hannah'
      user.email_address = 'hannah@mail.com'
      user.username = 'Hanny'
      user.password = 'AbCd1$2$3$4'

      repo.create(user)

      users = repo.all

      last_user = users.last
      expect(last_user.name).to eq 'Hannah'
      expect(last_user.email_address).to eq 'hannah@mail.com'
      expect(last_user.username).to eq 'Hanny'
      expect(last_user.password).to eq 'AbCd1$2$3$4'
    end
end
end