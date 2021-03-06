require_relative 'training'
require_relative 'user'

class Academy

	attr_accessor :training, :user

	def initialize
		@trainings = {}
		@users = {}
	end

	def add_training(params)
		training = Training.new(params["training_id"], params["training_day"], params["training_time"], params["training_instructor"])
		@trainings[training.id] = training
		return "> Treino de #{training.day}, #{training.time} cadastrado com sucesso."
	end

	def add_user(params)
		user = User.new(params["user_id"], params["user_name"])
		@users[user.id] = user
		return "> #{user.name} cadastrado com sucesso."
	end
		
	def list_trainings(params)
		result = "Dia | Hora | Instrutor \n "
		@trainings.each do |id, t| 
			result << "#{t.day} - #{t.time} - #{t.instructor} \n "
		end
		return result
	end

end

=begin
def test

	user = User.new("23", "SeuRAUL")

	treino = Training.new("45", "Seg", "19h", "Paulo")
	treino2 = Training.new("46", "Qua", "19h", "Raul")

	academia = Academy.new

	academia.add_user user
	academia.add_training treino
	academia.add_training treino2

	puts academia.list_trainings

end
=end