require 'peep'
require 'peep_repository'

describe PeepRepository do
def reset_peeps_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'chitter_challenge_test' })
    connection.exec(seed_sql)
end

before(:each) do
    reset_peeps_table
end

context 'all method' do
    it 'finds all peeps' do
        repo = PeepRepository.new
        peeps = repo.all

        expect(peeps.length).to eq(2)
        expect(peeps[0].id).to eq('1')
        expect(peeps[0].message).to eq('Welcome to Chitter!')
        expect(peeps[0].time).to eq('2022-01-13 17:19:23')
        expect(peeps[0].user_id).to eq('1')

        expect(peeps[1].id).to eq('2')
        expect(peeps[1].message).to eq('This is my first comment')
        expect(peeps[1].time).to eq('2020-07-09 14:04:45')
        expect(peeps[1].user_id).to eq('2')
    end
end

context 'create' do
    it 'creates a single peep' do
        repo = PeepRepository.new

        peep = Peep.new
        
        peep.message = 'My new message'
        peep.time = '2023-01-10 22:10:34'
        peep.user_id = '2'

        repo.create(peep)

        peeps = repo.all

        last_peep = peeps.last
        expect(last_peep.message).to eq('My new message')
        expect(last_peep.time).to eq('2023-01-10 22:10:34')
        expect(last_peep.user_id).to eq('2')
    end
  end
end