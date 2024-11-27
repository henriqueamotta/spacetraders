class OrdersController < ApplicationController
  before_action :set_cart, only: %i[new create remove_from_cart]
  before_action :set_order, only: %i[show destroy]


  def index
    @orders = Order.where(user: current_user) # Lista pedidos do usuário logado
  end

  def show
    # Detalhes de um pedido específico
  end

  def new
    @order = Order.new
    @subtotal = @cart_products.sum(&:price) # Calcula o subtotal dos produtos no carrinho
    @shipping_methods = {
      "Shooting Star Deliveries" => 0.35, # Frete padrão
      "Meteor Post Express" => 0.45      # Frete expresso
    }
    @selected_shipping_cost = @shipping_methods["Shooting Star Deliveries"] # Frete inicial
    @total = @subtotal + @selected_shipping_cost # Total inicial
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    @shipping_methods = {
      "Shooting Star Deliveries" => 0.35,
      "Meteor Post Express" => 0.45
    }
    selected_shipping_cost = @shipping_methods[params[:order][:shipping_method]]
    @order.total = @cart_products.sum(&:price) + selected_shipping_cost

    if @order.save
      session[:cart] = [] # Limpa o carrinho após o pedido ser salvo
      redirect_to @order, notice: 'Order was successfully placed!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @order.destroy
    redirect_to orders_url, notice: 'Order was successfully destroyed.'
  end

  def remove_from_cart
    product_id = params[:product_id].to_i
    session[:cart].delete(product_id) # Remove o item do carrinho

    # Recalcula os valores
    @cart_products = Product.where(id: session[:cart])
    @subtotal = @cart_products.sum(&:price)
    @shipping_methods = {
      "Shooting Star Deliveries" => 0.35,
      "Meteor Post Express" => 0.45
    }
    @selected_shipping_cost = @shipping_methods["Shooting Star Deliveries"]
    @total = @subtotal + @selected_shipping_cost

    # Cria um novo pedido para o formulário
    @order = Order.new

    # Renderiza novamente a página com os dados atualizados
    flash.now[:notice] = "Item removed from cart."
    render :new
  end




  private

  def set_order
    @order = Order.find(params[:id]) # Localiza o pedido pelo ID
  end

  def set_cart
    session[:cart] ||= [] # Inicializa o carrinho na sessão se estiver vazio
    @cart_products = Product.where(id: session[:cart]) # Busca produtos válidos no carrinho
  end

  def order_params
    params.require(:order).permit(:planet, :address, :shipping_method)
  end
end
