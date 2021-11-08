class ApplicationController < Sinatra::Base

  get '/' do
    { message: "Hello world" }.to_json
  end

  set :default_content_type, 'application/json'
  get '/games' do
    #get all games from the database
    games= Game.all
    # games= Game.all.order(:title) #if you want to sort by title
    # games= Game.all.order(:title).limit(10) if you want to set a limit to 10
    #return in json w/ array of all game data
    games.to_json
  end

  get '/games/:id' do
    game= Game.find(params[:id])
    game.to_json(only: [:id, :title, :genre, :price], include: {
      reviews: {only: [:comment, :score], include: {
        user: {only: [:name] }
      } }
    })
  end
end
