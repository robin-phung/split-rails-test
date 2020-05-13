class TestController < ApplicationController
  def index
    @callback_engage = "not_run"
    @callback_assignment = "not_run"
    @callback_finish = "not_run"

    @current_user = params[:user] || rand(100)

    if params[:test] == "true"
      @variant = ab_test("cohorting_test", "control" => 1, "alternative" => 0)
    else
      @variant = "ab_test not run"
    end

    ab_finished("cohorting_test") if params[:finish] == "true"
  end

  def current_user
    @current_user
  end

  def experiment_engagement_callback(trial)
    @callback_engage = "run"
  end

  def experiment_assignment_callback(trial)
    @callback_assignment = "run"
  end

  def experiment_conversion_callback(trial)
    @callback_finish = "run"
  end
end
