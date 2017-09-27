require 'sinatra'
require 'json'
require 'csv'

get '/' do
  404
end

get /\/hello\/([\w]+)/ do
  haml :hello
end

get /\/get_name_quantity\.(json|html)/ do |ext|
  @name = get_name(params[:name])
  if @name
    if ext == 'json'
      content_type :json
      @name.to_json
    else
      haml :name_quantity
    end
  else
    500
  end
end

get '/calc.html' do
  haml :calc
end

post '/calc.html' do
  @expression = params[:expression] || ''
  @result = calc(@expression)
  haml :calc
end


helpers do
  def get_name(name)
    if name
      # seek name in csv
      res = {name: name, quantity: 0}
      CSV.foreach('csv/names.csv') do |row|
        if row[0] == name.upcase
          res[:quantity] = row[1].to_i
          break
        end
      end
      res
    else
      nil
    end
  end

  def calc(expression)
    expression.to_s * 2
  end
end