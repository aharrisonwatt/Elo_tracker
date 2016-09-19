require 'net/http'
require 'json'

def save_file
  url = 'https://deadliefoe:IdK414yZ2tLz6vAFS2WDlMz36odipMtmBQWWCxwH@api.challonge.com/v1/tournaments/showdowngg-ChurningTheButter_82.json?include_participants=1&include_matches=1'
  uri = URI(url)
  response = Net::HTTP.get(uri)
  # JSON.parse(response)
  #
  File.open("../assets/tournament.json","w") do |f|
      f.write(response)
  end

  puts response
end
