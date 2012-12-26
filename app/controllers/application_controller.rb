class ApplicationController < ActionController::Base
  protect_from_forgery

  after_filter :flash_to_headers

  def flash_to_headers
    return unless request.xhr?
    msg = flash_message
    type = flash_type

    response.headers['X-Message'] = msg if msg
    response.headers['X-Message-Type'] = type.to_s if type

    flash.discard
  end

  private

  def flash_message
    [:error, :warning, :notice].each do |type|
      puts "TYPE #{type}"
      puts "FLASH TYPE #{flash[type].blank?}"
      unless flash[type].blank?
        puts "WTF!"
        return flash[type]
      end
    end
    nil
  end

  def flash_type
    [:error, :warning, :notice].each do |type|
      puts "TYPE #{type}"
      puts "FLASH TYPE #{flash[type].blank?}"
      unless flash[type].blank?
        puts "WTF!"
        return type
      end
    end
    nil
  end
end
