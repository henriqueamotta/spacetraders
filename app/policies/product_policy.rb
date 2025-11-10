class ProductPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # Os seeds criam usuários, então o 'index' (Shop) deve mostrar apenas os produtos que NÃO pertencem ao usuário logado (para que ele não possa comprar dele mesmo).
    def resolve
      if user.present?
        scope.where.not(user: user)
      else
        scope.all
      end
    end
  end

  # --- Regras de Ação ---

  # 1. Quem pode ver a página 'index' (Shop)?
  def index?
    true # Qualquer um pode visitar a loja
  end

  # 2. Quem pode ver a página 'show' (Detalhes)?
  def show?
    true # Qualquer um pode ver os detalhes de um produto
  end

  # 3. Quem pode criar (vender) um produto?
  def create?
    user.present? # Apenas se o usuário estiver logado
  end

  # 4. Quem pode editar?
  def update?
    # Apenas se o usuário estiver logado E
    # (record == @product)
    # (user == current_user)
    user.present? && record.user == user
  end

  # 5. Quem pode deletar?
  def destroy?
    # Mesma regra do 'update'
    user.present? && record.user == user
  end
end
