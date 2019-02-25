require 'open-uri'
class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @attempt = params[:word]
    @grid = params[:letters]
    @result = run_game(@attempt, @grid)
  end

  private

  def run_game(attempt, grid)
    dictionary = word_attempted(attempt)

    if dictionary["found"] == true && word_in_grid(attempt, grid) == true
      "Congratulations, @{attempt} is a valid English word"
    elsif dictionary["found"] == false
      "Sorry, but #{attempt} is not a valid english word"
    else
      "Sorry, but #{attempt} can't be built out of the grid"
    end
  end

  def word_attempted(attempt)
    url = 'https://wagon-dictionary.herokuapp.com/' + attempt
    JSON.parse(open(url).read)
  end

  def word_in_grid(attempt, grid)
    (attempt.upcase.split('') - grid.split('')).empty?
  end
end
