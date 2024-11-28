class ProductsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_product, only: %i[show edit update destroy]
  before_action :authorize_user!, only: %i[edit update destroy] # Verifica autorização

  def index
    if params[:category]
      @products = Product.where(category: params[:category].capitalize)
    else
      @products = Product.all
    end
  end

  def new
    @product = Product.new
  end

  def show
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user # Associa produto ao usuário logado

    if @product.save
      redirect_to @product, notice: 'Product was successfully added!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @product.update(product_params) # Atualiza o produto com os novos dados do formulário
      redirect_to @product, notice: 'Product was successfully updated!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize_user! # verificação de autorização do usuário
    @product.destroy
    redirect_to products_path, notice: 'Product was successfully deleted!'
  end

  def add_to_cart
    session[:cart] ||= []
    session[:cart] << params[:id].to_i
    redirect_to new_order_path, notice: "Item added to cart."
  end

  private

  def set_product
    @product = Product.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to products_path, alert: "Product not found."
  end

  def product_params
    params.require(:product).permit(:name, :model, :category, :price, :manufacturer, :overview, photos: [])
  end

  def authorize_user!
    unless @product.user_id == current_user.id
      redirect_to products_path, notice: 'You do not have permission to delete this product!'
    end
  end
end
