class ApplicationController < ActionController::Base
  protect_from_forgery

  after_filter :flash_to_headers

  REALM = 'unboxed'

  def flash_to_headers
    return unless request.xhr?
    msg = flash_message
    type = flash_type

    response.headers['X-Message'] = msg if msg
    response.headers['X-Message-Type'] = type.to_s if type

    flash.discard
  end

  def secure_with_digest
    return true if Rails.env.development? || Rails.env.test?

    authenticate_or_request_with_http_digest(REALM) do |username|
      password = ENV['UNBOXED_ADMIN']
      if password.blank?
        nil
      else
        Digest::MD5.hexdigest([username, REALM, password].join(":"))
      end
    end
  end
  private

  def flash_message
    [:error, :warning, :notice].each do |type|
      unless flash[type].blank?
        return flash[type]
      end
    end
    nil
  end

  def flash_type
    [:error, :warning, :notice].each do |type|
      unless flash[type].blank?
        return type
      end
    end
    nil
  end
end
