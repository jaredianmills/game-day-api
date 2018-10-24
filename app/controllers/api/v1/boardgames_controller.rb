class Api::V1::BoardgamesController < ApplicationController

  def search
    boardgames_response = []
    url = "https://www.boardgamegeek.com/xmlapi/search?search=#{params[:search_term]}"
    request = RestClient.get(url)
    boardgames = Hash.from_xml(request)
    if boardgames['boardgames']['boardgame']
      boardgames['boardgames']['boardgame'].each do |boardgame|
        boardgames_response << find_by_id(boardgame)
      end
      render json: boardgames_response
    else
      render json: {error: 'Could not find that game'}
    end
  end

  def search_by_id
    boardgame = params[:boardgame]
    boardgame_json = find_by_id(boardgame)
    render json: boardgame_json
  end

  def find_by_id(boardgame)
    boardgame_url = "https://www.boardgamegeek.com/xmlapi/boardgame/#{boardgame['objectid']}"
    boardgame_request = RestClient.get(boardgame_url)
    boardgame_details = Hash.from_xml(boardgame_request)
    title = Nokogiri::XML(boardgame_request).xpath('//name').find{|name| name.attributes['primary']}.text
    boardgame_details['boardgames']['boardgame'][:title] = title
    boardgame_details['boardgames']['boardgame']
  end

  def index
    @boardgames = Boardgame.all
    render json: @boardgames
  end

end
