module TrackingConcern
  extend ActiveSupport::Concerns

  def tracking_send_mail( model, action, options)
    options[:cookies] = cookies[:tracking_history]
    model.send(action, options).deliver_now
  end
end