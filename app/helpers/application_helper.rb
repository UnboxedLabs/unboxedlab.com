module ApplicationHelper
  def alert_type name
    case name
      when "notice"
        return "success"
      when "error"
        return "error"
      when "warning"
        return "info"
    end
  end
end
