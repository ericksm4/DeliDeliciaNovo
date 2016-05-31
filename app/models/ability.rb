class Ability
  include CanCan::Ability

  def initialize(user)
      user ||= User.new
      #can :manage, :all if user.roles_mask == 1
      can :manage, :all if user.is? :admin
      
      if user.is? :usuario 
        can :read, :all
      end
  end

  
end
