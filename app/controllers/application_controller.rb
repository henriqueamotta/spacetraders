class ApplicationController < ActionController::Base
  # 1. Liga o Pundit
  include Pundit::Authorization

  # 2. "Tranca" o site inteiro por padrão (Devise)
  before_action :authenticate_user!

  # 3. Captura erros do Pundit (para não quebrar a aplicação)
  # Se o Pundit der um erro de "Não autorizado"...
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    # Define um alerta flash
    flash[:alert] = "You are not authorized to perform this action."
    # E redireciona o usuário para a página anterior (ou para a home)
    redirect_to(request.referrer || root_path)
  end
end
