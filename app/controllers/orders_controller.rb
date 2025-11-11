class OrdersController < ApplicationController
  before_action :set_cart, only: %i[new create remove_from_cart]
  before_action :set_order, only: %i[show destroy order_confirmation]

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
    @subtotal = @cart_products.sum(&:price)
    @shipping_methods = 10.000
    @total = @subtotal

    # Pundit verifica se o usuário tem permissão para criar um pedido
    authorize @order
  end

  def create
    # Inicializa um novo pedido com os parâmetros fornecidos
    @order = Order.new(order_params)
    @order.user = current_user

    # Pundit verifica se o usuário tem permissão para criar este pedido
    authorize @order

    # Calcula o total do pedido
    @shipping_methods = 10.000

    @order.total = @cart_products.sum(&:price) + @shipping_methods
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

    @cart_products = Product.where(id: session[:cart])
    @subtotal = @cart_products.sum(&:price)
    @shipping_methods = 10.000
    @total = @subtotal + @shipping_methods
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

  def order_params
    params.require(:order).permit(:planet, :address, :shipping_method)
  end
end
