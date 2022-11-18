class QuotationPolicy < ApplicationPolicy
  def show?
    record.user == user
  end

  def create?
    true
  end

  def destroy?
    record.user == user
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      if user.role == "client"
        scope.where(user: user)
      else
        scope.where(artist: user)
      end
    end
  end
end
