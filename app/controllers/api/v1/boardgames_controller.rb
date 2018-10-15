class Api::V1::BoardgamesController < ApplicationController

  def search
    url = "https://www.boardgamegeek.com/xmlapi/search?search=#{params[:search_term]}"
    request = RestClient.get(url)
    response = Hash.from_xml(request)
    render json: response
  end

  def index
    @boardgames = Boardgame.all
    render json: @boardgames
  end
end
