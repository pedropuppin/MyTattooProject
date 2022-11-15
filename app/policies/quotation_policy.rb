class QuotationPolicy < ApplicationPolicy
  def create?
    user.role == "client"
  end

  def destroy
    user.role == "artist"
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.where(user: user)
    end
  end
end
