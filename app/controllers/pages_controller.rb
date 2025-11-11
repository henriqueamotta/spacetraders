class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :about ]

  def home
    # Destaque do Produto na Página Inicial
    @featured_product = Product.find_by(name: "Millennium Falcon")
  end

  def about
  end
end
