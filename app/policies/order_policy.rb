class OrderPolicy < ApplicationPolicy
  class Scope < Scope
    # O Pundit chama o 'resolve' automaticamente quando usado 'policy_scope(Order)'
    def resolve
      # Isto filtra TODOS os pedidos e retorna APENAS
      # aqueles onde o 'user_id' é o mesmo do 'current_user'
      scope.where(user: user)
    end
  end

  # Um usuário pode ver o seu histórico de pedidos (a página index)?
  def index?
    user.present? # Sim, se ele estiver logado.
  end

  # Um usuário pode ver um pedido específico (página show)?
  def show?
    # Sim, se ele estiver logado E o pedido pertencer a ele.
    user.present? && record.user == user
  end

  # Um usuário pode criar um pedido (página new/create)?
  def create?
    user.present? # Sim, se ele estiver logado.
  end

  # Um usuário pode deletar seu próprio pedido?
  def destroy?
    # Sim, se o pedido pertencer a ele
    user.present? && record.user == user
  end

  # A página de confirmação usa a mesma regra do 'show'
  def order_confirmation?
    show?
  end
end
