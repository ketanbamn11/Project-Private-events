class EventsController < ApplicationController
  before_action :set_current_user, if: :user_signed_in?, only: [:index]
  def index
    @events = Event.all
  end

  private

  def set_current_user
    @current_user = current_user
  end
end
