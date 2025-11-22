class DashboardPolicy < Struct.new(:user, :dashboard)
  # Quem pode ver a página "my_products"?
  def my_products?
    user.present? # Qualquer usuário logado
  end
end
