require 'net/http'
require 'json'
require 'rest-client'
# TODO: If response doesn't return anything skip number
def save_file
  url_start = 'https://deadliefoe:IdK414yZ2tLz6vAFS2WDlMz36odipMtmBQWWCxwH@api.challonge.com/v1/tournaments/showdowngg-ChurningTheButter_'
  url_end = '.json?include_participants=1&include_matches=1'

  (0..84).each do |num|
    url = url_start + num.to_s + url_end
    response = RestClient.get(url)

    open("../assets/tournament.json","a") do |f|
        f.puts(response)
    end
    puts response
  end
end

save_file
