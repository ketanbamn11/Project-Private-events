class EventAttendeesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event

  def create
    @event_attendee = @event.event_attendances.build(user: current_user)

    if @event_attendee.save
      redirect_to @event, notice: 'You have successfully joined the event.'
    else
      redirect_to @event, alert: 'There was an error joining the event.'
    end
  end

  def destroy
    @event_attendee = @event.event_attendances.find_by(user: current_user)

    if @event_attendee&.destroy
      redirect_to @event, notice: 'You have successfully left the event.'
    else
      redirect_to @event, alert: 'There was an error leaving the event.'
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end
