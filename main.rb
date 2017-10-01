require 'sinatra'
require 'json'
require 'csv'

get '/calc.html' do
  haml :calc
end

post '/calc' do
  if request.xhr?
    @expression = params[:expression] || ''
    @result = calc(@expression)
    "<h4>Result: #{@result.to_s}</h4>"
  else
    '<h1>Not an Ajax request!</h1>'
  end
end


helpers do
  def calc(expression)
    expression.to_s * 2
  end
end