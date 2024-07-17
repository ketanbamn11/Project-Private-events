class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authorize_event, only: [:edit, :update, :destroy]

  def index
    @past_events = Event.past
    @upcoming_events = Event.upcoming
  end

  def show
    @event_joined = EventAttendee.where(user_id: current_user, event_id: params[:id])
    @attendees = @event.attendees
  end

  def new
    @event = current_user.created_events.new
  end

  def create
    @event = current_user.created_events.new(event_params)
    if @event.save
      redirect_to user_path(current_user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @event.destroy
      flash[:notice] = 'Event deleted successfully.'
    else
      flash[:alert] = 'You are not authorized to delete this event.'
    end
    redirect_to user_path(current_user)
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def authorize_event
    unless @event.creator_id == current_user.id
      flash[:alert] = 'You are not authorized to perform this action.'
      redirect_to events_path
    end
  end

  def event_params
    params.require(:event).permit(:title, :description, :event_date).merge(creator_id: current_user.id)
  end
end
