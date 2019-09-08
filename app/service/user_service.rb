class UserService

  def self.create(email, password, password_confirmation)
    if User.exists?(email: email)
      { error: 'account already exists' }
    elsif password != password_confirmation
      { error: 'password and password confirmation do not match' }
    else
      { user: User.create(email: email, password: password, password_confirmation: password_confirmation) }
    end
  end

  def self.sign_in(email, password)
    user = User.find_by_email(email)

    if user.present?
      if user.authenticate(password)
        { auth_token: JsonWebToken.encode(user_id: user.id) }
      else
        { error: 'invalid credentials' }
      end
    else
      { error: 'invalid credentials' }
    end
  end

  def self.sign_out(user)
    if user.present?
      { auth_token: JsonWebToken.encode({ user_id: user.id }, 1.day.ago.to_i) }
    else
      { auth_token: nil }
    end
  end

  def self.authenticate(request_headers)
    if request_headers['Authorization'].present?
      decoded_auth_token = JsonWebToken.decode(request_headers['Authorization'].split(' ').last)

      if decoded_auth_token.present? && decoded_auth_token[:user_id].present?
        { user: User.find_by_id(decoded_auth_token[:user_id]) }
      else
        { error: 'invalid token' }
      end
    else
      { error: 'missing token' }
    end
  end
end
