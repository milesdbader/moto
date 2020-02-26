module ChallengeHelper
  def the_other_guy(challenge, some_guy)
    if challenge.challenger.user.id == some_guy.id
      return challenge.opponent.user
    else
      return challenge.challenger.user
    end
  end

  def remaining_time_string(challenge)
    seconds_left = challenge.expiration.strftime('%s').to_i - Time.now.strftime('%s').to_i

    if seconds_left <= 0
      return "Expired"
    # less than 15 min
    elsif seconds_left < 900
      return "Urgent!"
    # less than an hour
    elsif seconds_left < 3600
      return "#{seconds_left / 60} minutes"
    # less than a day
    elsif seconds_left < 86400
      hours = seconds_left / 3600
      minutes = (seconds_left - (hours * 3600)) / 60
      return "#{hours}h #{minutes} min"
    else
      days = seconds_left / 86400
      hours = (seconds_left - (days * 86400)) / 3600
      return "#{days} days #{hours}h"
    end
  end
end
