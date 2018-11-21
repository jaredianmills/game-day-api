class Api::V1::CollectionsController < ApplicationController

  def search
    url = "https://www.boardgamegeek.com/xmlapi/collection/#{params[:search_term]}"
    request = RestClient.get(url)
    collection = Hash.from_xml(request)

    while collection['message'] && collection['message'].include?('Please try again later')
      sleep 1
      request = RestClient.get(url)
      collection = Hash.from_xml(request)
    end

    if collection['errors']
      render json: collection['errors']
    else
      filtered_collection = collection['items']['item'].select {|game| game['status']['own'] === '1'}
      render json: filtered_collection
    end
  end


end
