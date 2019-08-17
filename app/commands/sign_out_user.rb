class SignOutUser
  prepend SimpleCommand

  def initialize(user)
    @user = user
  end

  def call
    # Set expiration in the past
    JsonWebToken.encode({ user_id: user.id }, 1.day.ago.to_i) if user
  end

  private

  attr_accessor :user
end