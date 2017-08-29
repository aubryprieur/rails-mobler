class GuestWishlistPolicy < ApplicationPolicy

    def show?
      true
    end

    def destroy?
      true
    end

    def add_item?
      true
    end

    def create?
      true
    end
end

