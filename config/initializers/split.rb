Split.configure do |config|
  config.db_failover = true # handle Redis errors gracefully
  config.db_failover_on_db_error = -> (error) { Rails.logger.error(error.message)}
  config.allow_multiple_experiments = true
  config.enabled = true
  config.persistence = Split::Persistence::RedisAdapter.with_config(
    lookup_by: -> (context) { context.current_user },
  )
  config.include_rails_helper = true
  config.on_trial = :experiment_engagement_callback # run on every trial
  config.on_trial_choose = :experiment_assignment_callback # run on trials with new users only
  config.on_trial_complete = :experiment_conversion_callback
end
