class Contact < ActiveRecord::Base
  attr_accessible :email, :ip, :name, :user_agent
end
