class WishlistPolicy < ApplicationPolicy

    def show?
      true
    end

    def destroy?
      true
    end
end

