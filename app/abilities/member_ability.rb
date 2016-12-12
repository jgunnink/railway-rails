class MemberAbility < BaseAbility

  def initialize(user)
    can :manage, User, id: user.id

    cannot :show, :admin_controllers
    cannot :show, :admin_dashboard
    can :show, :user_dashboard
    can :manage, Client
    cannot :destroy, Client
    can :manage, Project
    cannot :destroy, Project
  end

end
