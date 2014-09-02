class User < ActiveRecord::Base
  validates_presence_of :first_name, :last_name, :email
  validates_format_of :email, with: /@/
end