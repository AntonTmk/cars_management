# frozen_string_literal: true

module UserAuth
  # register data validator
  module LogOut
    def log_out(user_data_object)
      user_data_object.email = ''
      user_data_object.password_hash = ''
      user_data_object.status = false
      user_data_object
    end
  end
end
