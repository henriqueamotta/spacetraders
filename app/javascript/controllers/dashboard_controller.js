import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["gridView", "tableView", "gridBtn", "listBtn"]

  connect() {
    // Inicia no modo Grid por padrão
    this.showGrid()
  }

  showGrid() {
    // Mostra Grid, Esconde Tabela
    this.gridViewTarget.classList.remove("d-none")
    this.tableViewTarget.classList.add("d-none")

    // Atualiza estilo dos botões
    this.gridBtnTarget.classList.add("active")
    this.listBtnTarget.classList.remove("active")
  }

  showList() {
    // Mostra Tabela, Esconde Grid
    this.tableViewTarget.classList.remove("d-none")
    this.gridViewTarget.classList.add("d-none")

    // Atualiza estilo dos botões
    this.listBtnTarget.classList.add("active")
    this.gridBtnTarget.classList.remove("active")
  }
}
