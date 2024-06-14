class EventAttendeesController < ApplicationController
  before_action :authenticate_user!

  def create
    @event = Event.find(params[:event_id])
    @event_attendee = @event.event_attendances.build(user: current_user)

    if @event_attendee.save
      redirect_to @event, notice: 'You have successfully joined the event.'
    else
      redirect_to @event, alert: 'There was an error joining the event.'
    end
  end
end
