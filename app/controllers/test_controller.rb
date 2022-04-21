class TestController < ApplicationController
  def index
    @callback_engage = "not_run"
    @callback_assignment = "not_run"
    @callback_finish = "not_run"
    @experiment = "none given"
    @current_user = params[:user] || rand(100)
    @ab_user = ab_user
    @metadata_name = ""

    if !params[:experiment].nil?
      @experiment = params[:experiment]

      if params[:test] == "true"
        ab_test(@experiment) do |alternative, metadata|
          @variant = alternative
          @metadata = metadata
        end
      else
        @variant = "ab_test not run"
      end

      if params[:goal].present?
        ab_finished({ "#{params[:experiment]}": "#{params[:goal]}" }) if params[:finish] == "true"
      else
        ab_finished(params[:experiment]) if params[:finish] == "true"
      end
    end
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
    derp = trial.within_conversion_time_frame?
    @callback_finish = "run"
  end

  def ab_test_user_qualified?
    true
  end
end