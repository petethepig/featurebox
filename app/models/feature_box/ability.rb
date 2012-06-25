module FeatureBox
  class Ability
  
    include CanCan::Ability

    def initialize(user)
      user ||= FeatureBox::User.new # guest user (not logged in)
      if user.admin?
        can :read, :all
        can :read_protected, :all # read_protected is for signed in users only
        can :create, :all
        can :update, :all
        can :destroy, :all
      elsif user.id     # registered user
        can :read, [Suggestion, Comment]
        can :read_protected, [Suggestion, Comment]
        can :update, [Suggestion, Comment], :user_id => user.id
        can :destroy, [Suggestion, Comment], :user_id => user.id
        can :create, [Suggestion, Comment, Vote]
      else 
        can :read, [Suggestion, Comment]
      end
    end
  end
end
