
require_relative '../../config/requirements'


module CreateAccount
  def sing_up_menu
    puts "input email please:"
    email = gets.chomp
    puts "input password please:"
    password = gets.chomp
    create(email, password)
  end

  def create(email, password)
    @user = User.new
    @user.status = true
    @user.email = email
    @user.password = password
    @user.save!
    puts "Hello, #{email}!"
    {status: true, email: email, password: password}
  end
end
