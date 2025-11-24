class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy delete_photo]
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    @products = policy_scope(Product)

    # Filtro por Categoria
    if params[:category].present?
      # Usando ILIKE para ignorar maiúsculas/minúsculas (droids vs Droids)
      # O 'singularize' ajuda se o link for 'droids' e no banco estiver 'Droid' (opcional)
      @products = @products.where("category ILIKE ?", params[:category])
    end

    # Filtro por busca de nome
    if params[:search].present?
      @products = @products.where("name ILIKE ?", "%#{params[:search]}%")
    end
  end

  def show
    @product = Product.find(params[:id])
    # Autorizando a ação 'show?'
    # (Pundit checa 'show?' na ProductPolicy. Como é 'true', ele permite)
    authorize @product
  end

  def new
    @product = Product.new
    # Autorizando a ação 'create?'
    # (Pundit checa 'create?'. Se o usuário não estiver logado, ele dará erro)
    authorize @product
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user
    # Autorizando a ação 'create?' (igual ao 'new')
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
    authorize @product

    # Seleciona os parâmetros seguros
    clean_params = product_params

    # Extraindo as fotos dos parâmetros
    # O .delete(:photos) remove a chave :photos de clean_params e retorna o valor para a variável new_photos
    # Isso impede que o @product.update sobrescreva as fotos existentes.
    new_photos = clean_params.delete(:photos)

    # Atualizando os dados de texto (sem tocar nas fotos ainda)
    if @product.update(clean_params)

      # Lógica de Anexar (Append)
      if new_photos.present?
        # Limpa strings vazias que o formulário envia (ex: ["", "foto.jpg"])
        new_photos = new_photos.reject(&:blank?)

        # Se sobrou alguma foto válida, anexa ela às existentes
        # O método .attach() ADICIONA, não substitui.
        @product.photos.attach(new_photos) if new_photos.any?
      end

      redirect_to @product, notice: "Product was successfully updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product = Product.find(params[:id])
    # Autorizando a ação 'destroy?'
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
