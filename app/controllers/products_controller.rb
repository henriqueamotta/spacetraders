class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy delete_photo]
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    # 1. Aplicando o 'Scope' (da Policy)
    # Isso automaticamente chama o Scope.resolve (para não mostrar os produtos do próprio usuário)
    @products = policy_scope(Product)

    # Filtro de busca simples
    if params[:search].present?
      @products = @products.where("name ILIKE ?", "%#{params[:search]}%")
    end
  end

  def show
    @product = Product.find(params[:id])
    # 2. Autorizando a ação 'show?'
    # (Pundit checa 'show?' na ProductPolicy. Como é 'true', ele permite)
    authorize @product
  end

  def new
    @product = Product.new
    # 3. Autorizando a ação 'create?'
    # (Pundit checa 'create?'. Se o usuário não estiver logado, ele dará erro)
    authorize @product
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user
    # 4. Autorizando a ação 'create?' (igual ao 'new')
    authorize @product

    if @product.save
      redirect_to @product, notice: "Product was successfully added!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @product = Product.find(params[:id])
    # 5. Autorizando a ação 'update?'
    # (Pundit checa 'update?'. Se user != record.user, ele dará erro)
    authorize @product
  end

  def update
    @product = Product.find(params[:id])
    # 6. Autorizando a ação 'update?'
    authorize @product

    if @product.update(product_params)
      redirect_to @product, notice: "Product was successfully updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product = Product.find(params[:id])
    # 7. Autorizando a ação 'destroy?'
    authorize @product

    @product.destroy
    redirect_to products_path, notice: "Product was successfully deleted!"
  end

  def add_to_cart
    session[:cart] ||= []
    session[:cart] << params[:id].to_i
    redirect_to new_order_path, notice: "Item added to cart."
  end

  def delete_photo
    # Encontra a imagem pelo ID (que vem nos params)
    @photo = @product.photos.find(params[:photo_id])
    # Remove a imagem do Active Storage (purge = apaga do banco e do storage)
    @photo.purge

    # Responde com Turbo Stream para atualizar a página sem recarregar
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@photo) }
      format.html { redirect_to edit_product_path(@product), notice: "Photo deleted." }
    end
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
