class Api::V1::BoardgamesController < ApplicationController

  def search
    response = []
    url = "https://www.boardgamegeek.com/xmlapi/search?search=#{params[:search_term]}"
    request = RestClient.get(url)
    boardgames = Hash.from_xml(request)
    boardgames['boardgames']['boardgame'].each do |boardgame|
      boardgame_url = "https://www.boardgamegeek.com/xmlapi/boardgame/#{boardgame['objectid']}"
      boardgame_request = RestClient.get(boardgame_url)
      boardgame_details = Hash.from_xml(boardgame_request)
      title = Nokogiri::XML(boardgame_request).xpath('//name').find{|name| name.attributes['primary']}.text
      boardgame_details[:title] = title
      response << boardgame_details
    end
    render json: response
  end

  def index
    @boardgames = Boardgame.all
    render json: @boardgames
  end
end
