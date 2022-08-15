require "json"
require "open-uri"
require "set"

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @word = params[:word].downcase.chars.to_set
    @letters_sample = params[:letters].downcase.chars.to_set
    #  --> escrevo raise para ver os parametros. Nesse caso, o único parametro que tenho é a
    # word. Mas os parâmetros serão todos os input do tipo "text".
    if @word.subset?(@letters_sample)
      url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
      user_serialized = URI.open(url).read
      user = JSON.parse(user_serialized)
      if user["found"] == true
        @results = 'Congratulations'
      else
        @results = 'Sorry, try a valid word!'
      end
    else
      @results = 'Please, use letters from the options!'
    end
  end
end
# JSON.parse vai me devolver uma hash com as informações
