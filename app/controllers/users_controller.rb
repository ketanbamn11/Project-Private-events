class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :my_attended_event]

  def show
    @events = current_user.created_events
  end

  def my_attended_event
    @events = current_user.attended_events
  end
end
