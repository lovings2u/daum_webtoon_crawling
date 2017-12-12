require 'sinatra'
require 'sinatra/reloader'
require 'rest-client'
require 'json'

get '/' do
  send_file 'index.html'
end

get '/webtoon' do
  file_name = get_webtoon_list
  @webtoons = Array.new
  file = File.new("#{file_name}.json")
  result =JSON.parse(file.readlines[0])["data"]
  result.each do |webtoon|
    toon = {
      title: webtoon["title"],
      score: webtoon["averageScore"],
      intro: webtoon["introduction"],
      img_url: webtoon["pcThumbnailImage"]["url"],
      nick: webtoon["nickname"]
    }
    @webtoons << toon
  end
  puts "test"
  erb :webtoon
end

def get_webtoon_list
  timestamp = Time.now.to_i
  # puts timestamp
  week_day = Date.today.strftime('%a').downcase
  # puts week_day
  url = "http://webtoon.daum.net/data/pc/webtoon/list_serialized/" + week_day + "?timeStamp=" + timestamp.to_s
  # puts url
  webtoon_hash =RestClient.get(url)
  File.open("#{timestamp}.json", "w+") do |file|
    file.print webtoon_hash
  end
  timestamp
end
