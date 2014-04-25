class HomeController < ApplicationController
  def index
    require 'httparty'
    require 'json'
    if !params[:artist]
      render '/home/welcome'
    else
      response = HTTParty.get("http://api.songkick.com/api/3.0/search/artists.json?query=#{params[:artist].gsub!(' ', '%20')}&apikey=UqncZSiBYPTv4CI0")
      @date = response.parsed_response["resultsPage"]["results"]["artist"][0]["onTourUntil"].to_datetime
      @available = true
      if @date > params[:date].to_datetime
        @available = false
      end
    end
  end
  def welcome
  end
end
