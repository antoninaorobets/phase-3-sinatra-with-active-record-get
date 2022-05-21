class ApplicationController < Sinatra::Base
  set :default_content_type, "application/json"
  get '/' do
    { message: "Hello world" }.to_json
  end
  get '/games' do
    # get all the games from the database
    # return a JSON response with an array of all the game data
    Game.all.to_json
  end
  get '/games/:id' do
    id = params[:id]
    game = Game.find_by(id: id)
    game.to_json(only: [:id, :title, :genre, :price], include: {
      reviews: { only: [:comment, :score], include: {
        user: { only: [:name] }
      } }
    })
  end

end
