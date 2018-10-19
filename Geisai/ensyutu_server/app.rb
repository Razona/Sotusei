require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require 'open-uri'
require 'json'
require 'net/http'

require 'sinatra/activerecord'
require './models'


get '/' do
    erb :map
end

get '/form' do
    @x = params[:x]
    @y = params[:y]
    erb :form
end

get '/db_save' do
    redirect '/'
end

get '/admin' do
    
        File.open("public/history.csv","w") do |i|
           History.all.each do |history|
             team = history.team
             memo = history.memo
             y = history.y
             x = history.x
             i.puts "#{team},#{memo},#{x},#{y}"
           end
        end

    @histories = History.all
    erb :admin
end

get '/history.csv' do
    
end

get '/map' do
    @x = params[:x]
    @y = params[:y]
    redirect 'https://www.google.co.jp/maps/@'+params[:x].to_s+','+params[:y].to_s+',15z'
end

get '/team_a' do
    erb :a
end

get '/team_b' do
    erb :b
end

get '/team_c' do
    erb :c
end

post '/db' do
  @x = params[:x]
  @y = params[:y]
  @team = params[:team]
  @place = params[:place]
  @env = params[:env]
  @memo = params[:memo]
  
  erb :db
end

post '/db_save' do
  @x = params[:x]
  @y = params[:y]
  @team = params[:team]
  @place = params[:place]
  @env = params[:env]
  @memo = params[:memo]
  History.create!(x: params[:x], y: params[:y],team: params[:team],place: params[:place],env: params[:env],memo: params[:memo])
  redirect '/'
end
  

get '/db' do
    erb:db
end

get '/histories.json' do
    content_type :json, :charset => 'utf-8'
    histories = History.all
    histories.to_json
end


File.open("public/history.csv","w") do |i|
   History.all.each do |history|
     team = history.team
     memo = history.memo
     y = history.y
     x = history.x
     i.puts "#{team},#{memo},#{x},#{y}"
   end
end

