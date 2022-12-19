class PasswordValidator
  attr_accessor :password, :errors

  def initialize(password)
    @errors = []
    @password = password
  end

  def is_valid?
    if password_uppercase? && password_lower_case? &&
       password_contains_number? && password_special_char? &&
       @password.length > 8
      true
    else
      false
    end
  end

  def password_uppercase?
    !@password.match(/\p{Upper}/).nil?
    # unless !!@password.match(/\p{Upper}/)
    #   @errors << "#{@password}  must contain at least 1 uppercase "
    # end
  end

  def password_lower_case?
    !password.match(/\p{Lower}/).nil?
    # unless !password.match(/\p{Lower}/).nil?
    #   @errors << "#{@password} must contain at least 1 lowercase"
    # end
  end

  def password_special_char?
    special = "?<>',?[]}{=-)(*&^%$#`~{}!_"
    regex = /[#{special.gsub(/./){|char| "\\#{char}"}}]/
    !@password.match(regex).nil?
    # unless !@password.match(regex).nil?
    #   @errors << "#{@password} must contain special character"
    # end
  end

  def password_contains_number?
    @password.count("0-9") > 0
    # unless @password.count("0-9") > 0
    #  @errors << "#{@password} must contain at least one number"
    # end
  end
end
