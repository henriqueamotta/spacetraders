class ProductsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_product, only: %i[show edit update destroy]

  def index
    @products = Product.all
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
    @product.destroy
    redirect_to products_path, notice: 'Product was successfully deleted!'
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :model, :price, :manufacturer, :overview, :photos: [])
  end
end
