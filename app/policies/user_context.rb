class UserContext
  attr_reader :user, :child_id

  def initialize(user, child_id)
    @user = user
    @child_id = child_id
  end
end
