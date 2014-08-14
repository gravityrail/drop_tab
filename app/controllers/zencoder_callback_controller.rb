class ZencoderCallbackController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    output_id = params["output"]["id"]
    job_state = params["output"]["state"]
    #format = params["output"]["label"].to_sym
    width = params["output"]["width"]
    height = params["output"]["height"]
    duration = params["output"]["duration_in_ms"]

    video = Entry.where(:"zencoder_output_id" => output_id).first
    if job_state == "finished" && video
      video.zencoder_processed!(width, height, duration)
    end

    render :nothing => true
  end

end