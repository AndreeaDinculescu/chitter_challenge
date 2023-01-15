require_relative 'user'

class UserRepository

    def all
        
        sql = 'SELECT id, name, email_address, username, password FROM users;'
        result_set = DatabaseConnection.exec_params(sql, [])

        users = []

        result_set.each do |record|
            user = User.new
            user.id = record['id']
            user.name = record['name']
            user.email_address = record['email_address']
            user.username = record['username']
            user.password = record['password']

            users << user
        end
        return users
    end

    def create(user)
        sql = 'INSERT INTO users (name, email_address, username, password) VALUES ($1, $2, $3, $4) '
        sql_params = [user.name,user.email_address,user.username,user.password]
   
        DatabaseConnection.exec_params(sql,sql_params)
        return nil
      end
   
      def find(id)
        sql = 'SELECT * FROM users WHERE id = $1;'
   
        result_set = DatabaseConnection.exec_params(sql,[id])
   
        record = result_set[0]
   
          user = User.new
          user.id = record['id']
          user.name = record['name']
          user.email_address = record['email_address']
          user.username = record['username']
          user.password = record['password']
   
          return user
        end
    end
