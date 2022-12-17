
# require_relative '../../config/requirements'

# register
module CreateAccount
  EMAIL_REGEX = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/

  def registration_attempt?(email, password)
    if email_validator?(email) && password.length >= 4
      puts "Hello, #{email}!"
      true
    else
      puts 'Invalid email or password'
      false
    end
  end

  def email_validator?(email)
    email.match?(EMAIL_REGEX) && !find_by_email?(email)
  end

  private

  DB_USERS = 'users.yml'

  def find_by_email?(email)
    hash = FileProcess.read_content(DB_USERS)
    unless hash.nil? || hash.empty?
      hash.find { |user| user[:email] == email }.nil? ? false : true
    else
      false
    end
  end
end
