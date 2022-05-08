class HomeController < ApplicationController
  def index
    require 'net/http'
    require 'json'

    @url = "https://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=10001&distance=0&API_KEY=2F29EC45-B63A-497B-89AE-EC7EBFA98DFC"
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @output = JSON.parse(@response)
    
    # check for empty result
    if @output.empty?
      @final_output = "Error"
    else
      @final_output = @output [0] ['AQI'] 
    end
     if @final_output == "Error"
      @api_color  = "gray"
     elseif @final_output <= 50
     @api_color = "green"
     @api_description = "Moderate"
     elseif @final_output >= 51 && @final_output <= 100
     @api_color = "yellow"
     @api_description = "Ok"
     elseif @final_output >= 101 && @final_output <= 150
     @api_color = "orange"
     @api_description = "Normal"
     elseif @final_output >= 151 && @final_output <= 200
     @api_color = "red"
     @api_description = "Very normal"
     elseif @final_output >= 201 && @final_output <= 250
     @api_color = "purple"
     @api_description = "High"
     elseif @final_output >= 251 && @final_output <= 300
     @api_color = "maroon"
     @api_description = "Bad"

     end
  end

  def zipcode
    @zip_query = params[:zipcode]

    if params[:zipcode] == ""
      @zip_query = "Hey you forgot to enter a Zipcode"
    elsif params[:zipcode]
      # Do Api stuff

    require 'net/http'
    require 'json'

    @url = "https://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=' + @zip_query.to_s + '&distance=0&API_KEY=2F29EC45-B63A-497B-89AE-EC7EBFA98DFC"
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @output = JSON.parse(@response)

    # check for empty result
    if @output.empty?
      @final_output = "Error"
    else
      @final_output = @output [0] ['AQI'] 
    end
    if @final_output == "Error"
    end

     end
    end


  end


