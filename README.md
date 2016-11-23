[site]: elorater.herokuapp.com
[link]: https://en.wikipedia.org/wiki/Elo_rating_system

# EloTracker
[EloTracker Live][site]

EloTracker is a full-stack web application using a Ruby on Rails with a PostgresSQL database for the backend.  EloTracker uses Facebook's React.js design with a Redux architecture bundle with Webpack to deliver frontend content.  

###Methedology
All the data used for EloTracker was parsed from both the Smash.gg and Challonge API for ever past Street Fighter tournament hosted by ShowDown.  This data was used to seed match data necessary implement and calculate [elo rating System][link].  For each match that occurs the user’s current rating is used to generate a new rating for both players.  By generating new ratings historic data for a user’s ratings is maintained.

###Code Examples
Users keep a reference to their current rank in every game.
```Ruby
def self.update_users_rank
  ranking_object = Rating.sort_current_ratings

  ranking_object.keys.each do |game_name|
    ranking_object[game_name].each_with_index do |player, i|
      rank = i + 1
      user = User.find_by(username: player[0])
      user.update_current_rank(game_name, rank)
    end
  end
end
```

Matches are stored with date objects allowing ratings to recalculated correctly even when adding in historic data to the database.
```Ruby
def self.recalculate_ratings
  Rating.all.delete_all
  matches = Match.all.sort{ |a, b| a.date <=> b.date}
  matches.each do |match|
    match.record_results
  end
end
```

When seeding data to the database players clan tags have to parsed out to acquire their username.  
```Ruby
def remove_player_tag(name)
  player_tag = name.split("|").map(&:strip).last
  return player_tag.split('(').first if player_tag.include?('(')
  if player_tag.include?('[')
    if player_tag[0] == '['
      return player_tag.split(']').map(&:strip).last
    else
      return player_tag.split('[').map(&:strip).first
    end
  end
  return player_tag
end
```

##Future Direction
This section is going to outline a few of the features still coming for Elo Tracker
###Increasing API endpoints
First and foremost adding more API endpoints allowing statistic generation including player vs player statistics.
###CSS
Currently there is almost no CSS on EloTracker.  The priority for EloTracker was to get the data efficiently to the frontend but it is always nice to make sure things look pretty.
