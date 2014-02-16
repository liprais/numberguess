require "sinatra/base"

module Numb3rs
  def checkNumber(numb3r,guess)
    a = 0 
    b = 0 
    numb3r.each_with_index do |value,index|
      if guess.include?(value)
        if guess[index] == numb3r[index] 
          a = a + 1
        else
          b = b + 1 
        end
      end
    end
    return "#{a}A#{b}B"
  end
end

class NumberGuess < Sinatra::Base
  
  #enable :sessions
  
  include Numb3rs
  
  def generateNumber
    numb3r = []
    while numb3r.length < 4
      a = rand(10)
      numb3r.push(a) unless numb3r.include?(a)
    end
    return numb3r
  end

  configure do
    enable :sessions
  end
    
  get "/" do 
    @a = generateNumber
    session["number"] = @a #generateNumber.to_s
    erb:index
  end
  
  get "/check" do 
    guess = params[:guess].split("")
    numb3r = session["number"].join.split("")
    ans = checkNumber(numb3r,guess)
    if guess.length == 4
      result = 
      case when ans == '4A0B' then "match!"
          else ans  
      end
    else 
      "please enter four digit number :-)"
    end
  end
    
  run!
end


