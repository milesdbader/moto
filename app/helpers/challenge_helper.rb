module ChallengeHelper
  def the_other_guy(challenge, some_guy)
    if challenge.challenger.user.id == some_guy.id
      return challenge.opponent.user
    else
      return challenge.challenger.user
    end
  end
end
