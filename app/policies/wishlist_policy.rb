class WishlistPolicy < ApplicationPolicy

    def show?
      true
    end

    def destroy?
      true
    end

    def add_item?
      true
    end
end

