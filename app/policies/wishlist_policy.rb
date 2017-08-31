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

    def create?
      true
    end

    def update?
      true
    end
  
    def add_and_create?
      true
    end
end

