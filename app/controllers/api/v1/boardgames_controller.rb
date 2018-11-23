class Api::V1::BoardgamesController < ApplicationController

  def search
    boardgames_response = []
    url = "https://www.boardgamegeek.com/xmlapi/search?search=#{params[:search_term]}"
    request = RestClient.get(url)
    boardgames = Hash.from_xml(request)['boardgames']['boardgame']
    if boardgames
      boardgames.each do |boardgame|
        boardgames_response << find_by_id(boardgame)
      end
      render json: boardgames_response
    else
      render json: {error: "We couldn't find any matching games"}
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
    boardgame_details = boardgame_details['boardgames']['boardgame']
    boardgame_details[:title] = title
    suggested_num_players = boardgame_details['poll'].find {|poll| poll['name'] = 'suggested_numplayers'}['results']
    highest_num_votes = 0
    best_at = nil
    if suggested_num_players.class == Array
      suggested_num_players.each do |result|
        num_players = result['numplayers']
        votes = result["result"].find {|poll_result| poll_result["value"] == "Best"}['numvotes'].to_i
        if votes > highest_num_votes
          highest_num_votes = votes
          best_at = num_players
        end
      end
    end
    boardgame_details["best_at"] = best_at
    boardgame_details
  end

  def index
    @boardgames = Boardgame.all
    render json: @boardgames
  end

  def create
    @boardgame = Boardgame.new(boardgame_params)

    if @boardgame.save
      render json: @boardgame
    else
      render json: { error: @boardgame.errors.full_messages }
    end
  end

  private

  def boardgame_params
    params.require(:boardgame).permit(:user_id, :objectid)
  end

end
