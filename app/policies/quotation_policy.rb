class QuotationPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def create?
    user.role == "client"
  end

  def destroy
    user.role == "artist"
  end
end
