class MessagePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.role == "client"
        scope.where(user: user)
      else
        scope.where(artist: user)
      end
    end
  end

  def messages?
    record.user == user || record.artist == user
  end

  def create?
    record.user == user || record.artist == user
  end
end
