class OrdersController < ApplicationController
  before_action :set_cart, only: %i[new create remove_from_cart]
  before_action :set_order, only: %i[show destroy order_confirmation]
  before_action :ensure_cart_is_not_empty, only: %i[create]

  def index
    # Pundit chama 'policy_scope' para aplicar a política de escopo definida em OrderPolicy
    @orders = policy_scope(Order).includes(:products)
  end

  def show
    # Pundit verifica se o usuário tem permissão para ver este pedido
    authorize @order
  end

  def new
    # Inicializa um novo pedido
    @order = Order.new

    # O cálculo manual é substituído por este método auxiliar para evitar repetição
    # e garantir que as variáveis (@subtotal, @total) existam.
    recalculate_totals

    # Pundit verifica se o usuário tem permissão para criar um pedido
    authorize @order
  end

  def create
    # Inicializa um novo pedido com os parâmetros fornecidos
    @order = Order.new(order_params)
    @order.user = current_user

    # Pundit verifica se o usuário tem permissão para criar este pedido
    authorize @order

    # O recálculo é chamadado aqui
    # Se o @order.save falhar lá embaixo, o 'render :new' precisa dessas variáveis (@subtotal) preenchidas
    recalculate_totals

    # Variáveis de instância calculadas acima
    @order.total = @total
    @order.products = @cart_products

    if @order.save
      session[:cart] = [] # Limpa o carrinho após salvar

      redirect_to order_confirmation_order_path(@order), notice: 'Order was successfully placed!'
    else
      Rails.logger.debug "Order Errors: #{@order.errors.full_messages}"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    # Pundit verifica se o usuário tem permissão para deletar este pedido
    authorize @order

    @order.destroy
    redirect_to orders_url, notice: 'Order was successfully destroyed.'
  end

  def remove_from_cart
    product_id = params[:product_id].to_i
    session[:cart].delete(product_id)

    # Verificação extra de segurança e UX
    # Se o carrinho ficar vazio, redireciona para produtos em vez de quebrar a lógica
    if session[:cart].empty?
      return redirect_to products_path, alert: "Your cart is empty."
    end

    # Recarrega os produtos (agora sem o item removido)
    @cart_products = Product.where(id: session[:cart])

    # Uso do método centralizado para recalcular os valores após a remoção
    recalculate_totals

    @order = Order.new

    flash.now[:notice] = "Item removed from cart."
    render :new, status: :unprocessable_entity
  end

  def order_confirmation
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def set_cart
    session[:cart] ||= []
    @cart_products = Product.where(id: session[:cart])
  end

  # Garante que o carrinho não esteja vazio antes de prosseguir para checkout
  def ensure_cart_is_not_empty
    if @cart_products.empty?
      redirect_to products_path, alert: "Your cart is empty. Please add items before checking out."
    end
  end

  # Centraliza a lógica de cálculo de valores.
  # Usado em new, create (em caso de erro) e remove_from_cart.
  def recalculate_totals
    @subtotal = @cart_products.sum(&:price)
    @shipping_methods = 10000.0 # Valor fixo por enquanto (pode virar lógica dinâmica depois)
    @total = @subtotal + @shipping_methods
  end

  def order_params
    params.require(:order).permit(:planet, :address, :shipping_method)
  end
end
