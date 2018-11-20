class Api::V1::CollectionsController < ApplicationController

  def search
    url = "https://www.boardgamegeek.com/xmlapi/collection/#{params[:search_term]}"
    request = RestClient.get(url)
    collection = Hash.from_xml(request)
    filtered_collection = collection['items']['item'].select {|game| game['status']['own'] === '1'}

    if filtered_collection
      render json: filtered_collection
    else
      self.search
    end
  end

end
