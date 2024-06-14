class EventsController < ApplicationController
  before_action :set_current_user, if: :user_signed_in?, only: [:index, :new, :show, :create, :destroy]

  def index
    @past_events = Event.past
    @upcoming_events = Event.upcoming
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

  def destroy
    @event = Event.find_by(id: params[:id])
    if @event && @event.creator_id == @current_user.id
      @event.destroy!
      flash[:notice] = "Event deleted successfully."
    else
      flash[:alert] = "You are not authorized to delete this event."
    end
    redirect_to user_path(@current_user)
  end

  private

  def set_current_user
    @current_user = current_user
  end

  def event_params
    params.require(:event).permit(:title, :description, :event_date).merge(creator_id: @current_user.id)    
  end
end
