class Api::V1::CollectionsController < ApplicationController

  def search
    url = "https://www.boardgamegeek.com/xmlapi/collection/#{params[:search_term]}"
    request = RestClient.get(url)
    collection = Hash.from_xml(request)
    filtered_collection = collection['items']['item'].select {|game| game['status']['own'] === '1'}
    # fetched_collection = filtered_collection.map {|boardgame| get_single_game(boardgame)}
    # render json: fetched_collection
    render json: filtered_collection
  end

  def get_single_game(boardgame)
    boardgame_url = "https://www.boardgamegeek.com/xmlapi/boardgame/#{boardgame['objectid']}"
    boardgame_request = RestClient.get(boardgame_url)
    boardgame_details = Hash.from_xml(boardgame_request)
    title = Nokogiri::XML(boardgame_request).xpath('//name').find{|name| name.attributes['primary']}.text
    boardgame_details['boardgames']['boardgame'][:title] = title
    boardgame_details['boardgames']['boardgame']

  end


  def show
  end
end
