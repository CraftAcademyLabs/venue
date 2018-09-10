class CampaignPolicy < ApplicationPolicy

    def new?
        !user.fan?
    end

    def create?
        new?
    end

    def index?
        true
    end

    def show?
        true
    end

    def update?
        user.admin?
    end

    def destroy?
        user.admin?
    end
end