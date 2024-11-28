import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["subtotal", "shipping", "total", "cart"];

  connect() {
    console.log("Checkout Controller connected.");
    this.shippingCost = 1.0; // Definir o custo padrão do envio
  }

  // Método chamado ao alterar o método de envio
  updateShipping(event) {
    const selectedMethod = event.target.value;

    // Define o custo de envio com base no método selecionado
    this.shippingCost = selectedMethod === "Shooting Star Deliveries" ? 1.0 : 2.5;

    this.updateTotal();
  }

  // Método chamado ao remover um item
  removeItem(event) {
    // Atualizar o subtotal e a lista de itens após a remoção (simulação)
    const itemElement = event.target.closest("li");
    const itemPrice = parseFloat(itemElement.dataset.price);

    // Atualizar subtotal e total
    const currentSubtotal = parseFloat(this.subtotalTarget.dataset.value);
    const newSubtotal = currentSubtotal - itemPrice;

    this.subtotalTarget.dataset.value = newSubtotal.toFixed(2);
    this.subtotalTarget.innerText = `BTC ${newSubtotal.toFixed(2)}`;

    // Atualizar total
    this.updateTotal();

    // Remover o item do DOM
    itemElement.remove();
  }

  // Atualiza o total com base no subtotal e no frete
  updateTotal() {
    const subtotal = parseFloat(this.subtotalTarget.dataset.value);
    const total = subtotal + this.shippingCost;

    this.shippingTarget.innerText = `BTC ${this.shippingCost.toFixed(2)}`;
    this.totalTarget.innerText = `BTC ${total.toFixed(2)}`;
  }
}
