module TrackingConcern
  extend ActiveSupport::Concerns

  def tracking_send_mail( model, action, options)
    options[:cookies] = cookies[:tracking_history]
    model.send(action, options).deliver_now
  end

  def tracking_history
    star_cookies_history = cookies[:tracking_history] ? true : false
    if trackable?
      cookies_tracking_history.push(referer_full_url) if cookies_tracking_history.empty?
      cookies_tracking_history.push(original_path)
      set_tracking_history

      store_tracking(star_cookies_history)
    end
  end

  def trackable?
    !request.path.start_with?("/admin")
  end

  def cookies_tracking_history
    return @cookies_tracking_history if @cookies_tracking_history.present?
    @cookies_tracking_history = cookies[:tracking_history] ? cookies[:tracking_history].split(",") : []
  end

  def original_path
    date_time = DateTime.now.strftime("%a %b %d %Y %H:%M:%S %Z") 
    date_time + " | " + request.original_url
  end

  def referer_full_url
    request.referer.present? ? "Referrer URL: " + request.referer : "Referrer URL: "
  end

  def set_tracking_history
    cookies[:tracking_history] = cookies_tracking_history.join(',')
  end

  def store_tracking(star_cookies_history)
    user_email = nil
    if has_devise?
      if send(current_model_devise).present?
        user_email = send(current_model_devise).email
      end
    end
    if star_cookies_history
      tracking = Tracking.where(ip_address: request.remote_ip, user_email: user_email).order(id: :desc).first_or_initialize
    else
      tracking = Tracking.new
    end
    tracking.history = cookies[:tracking_history]
    tracking.ip_address = request.remote_ip
    tracking.user_email = user_email
    tracking.save
  end

  def has_devise?
    TrackingFwz.model_devise.present?
  end

  def current_model_devise
    "current_#{TrackingFwz.model_devise}"
  end
end