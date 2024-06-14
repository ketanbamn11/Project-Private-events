class EventsController < ApplicationController
  before_action :set_current_user, if: :user_signed_in?, only: [:index, :new, :show, :create]

  def index
    @events = Event.all
  end

  def show
    @event = Event.find_by(id: params[:id])
    @event_joined = EventAttendee.where(user_id: @current_user, event_id: params[:id])
    @attendees = @event.attendees
  end

  def new
    @event = @current_user.created_events.new()
  end

  def create
    @event = @current_user.created_events.new(event_params)
    if @event.save
      redirect_to user_path(@current_user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_current_user
    @current_user = current_user
  end

  def event_params
    params.require(:event).permit(:title, :description, :event_date).merge(creator_id: @current_user.id)    
  end
end
