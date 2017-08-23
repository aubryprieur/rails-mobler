class WishlistPolicy < ApplicationPolicy


    def show?
      record.user == current_user
    end
end

