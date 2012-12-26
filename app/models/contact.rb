class Contact < ActiveRecord::Base
  attr_accessible :email, :ip, :name, :user_agent

  validates :email, :uniqueness => true
end
