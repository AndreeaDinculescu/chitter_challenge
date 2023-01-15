require_relative 'peep'

class PeepRepository

    def all
        sql = 'SELECT id, message, time, user_id FROM peeps;'
        result_set = DatabaseConnection.exec_params(sql, [])

        peeps = []

        result_set.each do |record|
            peep = Peep.new
            peep.id = record['id']
            peep.message = record['message']
            peep.time = record['time']
            peep.user_id = record['user_id']

            peeps << peep
        end
        return peeps
    end

    def create(peep)
        sql = 'INSERT INTO peeps (message, time, user_id) VALUES ($1, $2, $3);'
        sql_params = [peep.message, peep.time, peep.user_id]

        DatabaseConnection.exec_params(sql, sql_params)

        return nil
    end

    def find(id)
        sql = 'SELECT * FROM peeps WHERE id = $1;'
       
        result_set = DatabaseConnection.exec_params(sql, [user_id])
        
        peeps = []

        result_set.each do |record|
        peep = Peep.new
        peep.id = record['id']
        peep.message = record['message']
        peep.time = record['time']
        peep.user_id = record['user_id']

        peeps << peep
        end
        return peeps
    end
end