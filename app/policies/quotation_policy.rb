class QuotationPolicy < ApplicationPolicy
  def show?
    # como autorizar apenas os dois usuários (artista e cliente) da quotation
  end

  def create?
    user.role == "client"
  end

  def destroy
    user.role == "artist" && "client"
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.where(user: user)
    end
  end
end
