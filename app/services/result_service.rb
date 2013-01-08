class ResultService
  def self.create(game, params)
    result = game.results.build

    (params[:teams] || []).each.with_index do |team, index|
      result.teams.build rank: index + 1, player_ids: team[:players]
    end

    if result.valid?
      Result.transaction do
        RatingService.update(game, result.teams)
        result.save!

        OpenStruct.new(
          :success? => true,
          :result => result
        )
      end
    else
      OpenStruct.new(
        :success? => false,
        :result => result
      )
    end
  end

  def self.destroy(result)
    return OpenStruct.new(:success? => false) unless result.most_recent?

    Result.transaction do
      [result.winner, result.loser].each do |player|
        player.rewind_rating!(result.game)
      end

      result.destroy

      OpenStruct.new(:success? => true)
    end
  end
end
