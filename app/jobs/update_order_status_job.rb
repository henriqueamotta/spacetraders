class UpdateOrderStatusJob < ApplicationJob
  queue_as :default

  def perform(order_id)
    # 1. Encontra o pedido no banco de dados
    order = Order.find(order_id)

    # 2. Atualiza o status
    order.update(status: "Delivered")

    # Log para acompanhar no terminal
    puts "✅ ENCOMENDA ENTREGUE: Order ##{order.id} status updated to Delivered."
  end
end
