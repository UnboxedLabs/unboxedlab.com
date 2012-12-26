class Contact < ActiveRecord::Base
  attr_accessible :email, :ip, :name, :user_agent

  validates :email, :uniqueness => true

  def self.statistics
    hourly_contacts = { }
    daily_contacts  = { }

    Contact.all(:order => "created_at DESC" ).each do |c|
      hourly_key = c.created_at.strftime( "%Y%m%d%H" )
      daily_key  = c.created_at.strftime( "%Y%m%d")
      hourly_contacts[hourly_key] = (hourly_contacts[hourly_key] || 0) + 1
      daily_contacts[daily_key] = (daily_contacts[daily_key] || 0) + 1
    end

    [hourly_contacts, daily_contacts]
  end
end
