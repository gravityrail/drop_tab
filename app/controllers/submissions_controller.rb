class SubmissionsController < ApplicationController
  def index
    @entries = Entry.order("created_at desc").all
  end
end
