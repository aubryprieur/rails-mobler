class OrderPolicy < ApplicationPolicy

    def show?
      true
    end

    def create?
      true
    end
end
