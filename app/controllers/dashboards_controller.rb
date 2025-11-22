class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def my_products
    # Busca os produtos que pertencem ao usuário atualmente logado
    @products = current_user.products

    # Verifica se o usuário tem permissão para acessar esta ação
    authorize :dashboard, :my_products?
    # Símbolo :dashboard porque não há model Dashboard
  end
end
