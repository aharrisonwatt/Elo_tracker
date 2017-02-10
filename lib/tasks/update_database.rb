def update_matches_with_tournamentid
  Tournament.all.each do |tournament|
    Match.where('date = ?', tournament.date).each do |match|
      match.tournament_id = tournament.id
      match.save!
    end
  end
end

update_matches_with_tournamentid
