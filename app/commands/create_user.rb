class CreateUser
  prepend SimpleCommand

  def initialize(email, password, password_confirmation)
    @email = email
    @password = password
    @password_confirmation = password_confirmation
  end

  def call
    JsonWebToken.encode(user_id: user.id) if user
  end

  private

  attr_accessor :email, :password, :password_confirmation

  def user
    if existing_user
      errors.add :user_creation, 'account could not be created'

      nil 
    elsif valid?
      User.create!(email: email, password: password, password_confirmation: password_confirmation)
    else
      errors.add :user_creation, 'invalid'

      nil 
    end
  end

  def existing_user
    User.find_by_email(email)
  end

  def valid?
    email.present? && password.present? && password_confirmation.present? && password == password_confirmation
  end
end
