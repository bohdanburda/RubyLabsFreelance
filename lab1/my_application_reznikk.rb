module MyApplicationReznik

require 'singleton'
require 'pony'

class MyApplicationReznikk
  include Singleton

  attr_accessor :web_address, :validator, :file_ext, :parse_item, :user

  def initialize
    @web_address = nil
    @validator = nil
    @file_ext = 'rb'
    @parse_item = nil
    @user = User.new('login', 'password')
  end

  def send_email(subject, body)
    Pony.mail({
      to: @user.login,
      via: :smtp,
      subject: subject,
      body: body,
      via_options: {
        address: 'smtp.gmail.com',
        port: '587',
        user_name: @user.login,
        password: @user.password,
        authentication: :plain,
        domain: 'gmail.com'
      }
    })
  end
end

class User
  attr_accessor :login, :password

  def initialize(login, password)
    @login = login
    @password = password
  end
end

end