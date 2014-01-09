class LdapUser
  
  attr_accessor :id, :username, :full_name, :email

  def initialize(id, username, fullname, location, email)
    @id       = id
    @username = username
    @full_name = full_name
    @email    = email
  end

  class << self
    def find_user(username)
      LdapAuth.new(username).entities.first
    end
  end
end
