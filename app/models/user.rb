class User < ActiveRecord::Base

  def self.find_or_create_from_auth_hash(auth_hash)
    user = where(username: auth_hash[:info][:nickname]).first_or_create
    #raise :test
    user
  end
end
