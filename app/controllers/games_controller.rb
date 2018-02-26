   require "json"
    require "open-uri"

class GamesController < ApplicationController


  def new
      @letters = []
    10.times do |i|
      i = ("a"..."z").to_a.sample.upcase
      @letters << i
    end
  session[:new_var] = @letters
  end

  def score
    grid = session[:new_var]
    grid.map! { |element| element.downcase }
    @attempt = params[:word]
    @attempt = @attempt.downcase
    result = Hash.new(0)
    api_url = "https://wagon-dictionary.herokuapp.com/#{@attempt}"

    open(api_url) do |stream|
      res = JSON.parse(stream.read)
      if res["found"] == false
        result[:message] = "not an english word"
        result[:score] = 0
      else
        array = @attempt.split("")
        dup_array = array.dup

        grid.each_with_index do |letter|
          if dup_array.include? letter
            index = dup_array.find_index(letter)
            dup_array.delete_at(index)
          end
        end

        if  dup_array.length > 0
          result[:message] = "the given word is not in the grid"
          result[:score] = 0
        else
          result[:message] = "well done"
          result[:score] = 10*array.length
        end
      end
    end
    @result = result
  end
end
