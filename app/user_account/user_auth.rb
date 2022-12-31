# require_relative 'auth_modules/account_login'
# require_relative 'auth_modules/log_out'
# require_relative 'auth_modules/create_account'

module UserAuth
  extend AccountLogin
  extend LogOut
  extend CreateAccount
end
