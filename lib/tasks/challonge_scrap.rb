require 'net/http'
require 'json'

def save_file
    url = 'https://deadliefoe:IdK414yZ2tLz6vAFS2WDlMz36odipMtmBQWWCxwH@api.challonge.com/v1/tournaments/showdowngg-ChurningTheButter_82.json?include_participants=1&include_matches=1'
    uri = URI(url)
    response = Net::HTTP.get(uri)
    # JSON.parse(response)
    #
    File.open("test.json","w") do |f|
        f.write(response)
    end

    puts response
end

def record_matches
  a = nil
  File.open("test.json", 'r') do |f|
    f.each_line do |line|
      a = line
    end
  end

  a = JSON.parse(a)

  a['tournament']['participants'].each do |participant|
  end
end
