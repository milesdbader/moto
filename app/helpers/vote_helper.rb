module VoteHelper
  def vote_percentage_share(a_player, a_challenge)
    his_vote_count = a_player.votes.count
    total_vote_count = a_challenge.vote_count * 1.0
    return 0 if total_vote_count == 0;
    return ((his_vote_count / total_vote_count) * 100).round
  end
end
