class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :my_attended_event]
  before_action :set_current_user

  def show
    @events = current_user.created_events
  end

  def my_attended_event
    @attended_events = current_user.attended_events
  end

  private
  def set_current_user
    @current_user = current_user
  end
end