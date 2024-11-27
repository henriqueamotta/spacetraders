import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["shippingMethod", "subtotal", "shipping", "total"];

  connect() {
    this.updateTotal(); // Atualiza o total quando a página carrega
  }

  updateTotal() {
    // Pega o valor do método de envio selecionado
    const shippingCost = parseFloat(this.shippingMethodTarget.value) || 0;
    // Pega o valor do subtotal (definido no HTML)
    const subtotal = parseFloat(this.subtotalTarget.dataset.value) || 0;
    // Calcula o total
    const total = subtotal + shippingCost;

    // Atualiza os elementos na tela
    this.shippingTarget.innerText = `BTC ${shippingCost.toFixed(2)}`;
    this.totalTarget.innerText = `BTC ${total.toFixed(2)}`;
  }
}
