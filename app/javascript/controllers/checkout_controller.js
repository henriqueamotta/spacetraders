import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["subtotal", "shipping", "total", "cart"];

  // --- Custos de frete ---
  SHIPPING_STANDARD = 10000.0;
  SHIPPING_EXPRESS = 25000.0;

  connect() {
    console.log("Checkout Controller connected.");
    this.shippingCost = this.SHIPPING_STANDARD;

    // Formata os valores iniciais assim que a página carrega
    this.updateTotal();
  }

  // --- HELPER DE FORMATAÇÃO ---
  // Formata um número (ex: 1000299999) para "₿ 1,000,299,999.00"
  formatCurrency(value) {
    // Utilizando 'en-US' como padrão para obter (,) como separador de milhar e (.) como decimal
    const formatter = new Intl.NumberFormat('en-US', {
      minimumFractionDigits: 2, // Garante 2 casas decimais
      maximumFractionDigits: 2
    });
    return `₿ ${formatter.format(value)}`;
  }
  // ------------------------------

  updateShipping(event) {
    const selectedMethod = event.target.value;

    this.shippingCost = selectedMethod === "Shooting Star Deliveries"
      ? this.SHIPPING_STANDARD
      : this.SHIPPING_EXPRESS;

    this.updateTotal();
  }

  removeItem(event) {
    const itemElement = event.target.closest("li");
    const itemPrice = parseFloat(itemElement.dataset.price);

    const currentSubtotal = parseFloat(this.subtotalTarget.dataset.value);
    const newSubtotal = currentSubtotal - itemPrice;

    // Atualiza o 'data-value' (o número cru)
    this.subtotalTarget.dataset.value = newSubtotal;

    // Atualiza o texto visível (formatado)
    this.subtotalTarget.innerHTML = this.formatCurrency(newSubtotal);

    this.updateTotal();
    itemElement.remove();
  }

  updateTotal() {
    const subtotal = parseFloat(this.subtotalTarget.dataset.value);
    const total = subtotal + this.shippingCost;

    // Usando o novo helper de formatação
    this.shippingTarget.innerHTML = this.formatCurrency(this.shippingCost);
    this.totalTarget.innerHTML = this.formatCurrency(total);
  }
}
