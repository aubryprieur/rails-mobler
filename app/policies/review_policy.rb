class ReviewPolicy < ApplicationPolicy

    def resolve
      scope.all
    end

    def create?
      true
    end

end
