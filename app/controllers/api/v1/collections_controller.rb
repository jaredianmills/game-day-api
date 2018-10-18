class Api::V1::CollectionsController < ApplicationController
  def search
    url = "https://www.boardgamegeek.com/xmlapi/collection/#{params[:search_term]}"
    request = RestClient.get(url)
    collection = Hash.from_xml(request)
    render json: collection
  end

  def show
  end
end
