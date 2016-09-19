json.extract!(
  rating,
  :game_id, :elo, :user_id
)

json.user rating.user
