import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "previewContainer"]

  connect() {
    // Cria um objeto DataTransfer para guardar os arquivos em memória
    this.dt = new DataTransfer();
  }

  // Chamado quando o usuário seleciona arquivos no input
  addFiles(event) {
    const newFiles = this.inputTarget.files;

    // Adiciona os novos arquivos ao DataTransfer (Acumular)
    for (let i = 0; i < newFiles.length; i++) {
      // Evitar duplicatas verificando se o arquivo já existe
      let fileExists = false;
      for (let j = 0; j < this.dt.items.length; j++) {
        if (this.dt.items[j].kind === "file" && this.dt.items[j].getAsFile().name === newFiles[i].name) {
          fileExists = true;
          break;
        }
      }
      if (!fileExists) {
        this.dt.items.add(newFiles[i]);
      }
    }

    // Atualiza o input real com a lista acumulada
    // Isso é o que garante que TODOS os arquivos serão enviados, não só os últimos
    this.inputTarget.files = this.dt.files;

    // Renderiza as miniaturas
    this.renderPreviews();
  }

  // Chamado quando clica no "X" de uma miniatura nova
  removeFile(event) {
    // Pega o índice do arquivo que será removido (passado via data-param)
    const indexToRemove = event.params.index;

    // Cria um NOVO DataTransfer para reconstruir a lista sem o arquivo removido
    const newDt = new DataTransfer();
    const currentFiles = this.dt.files;

    for (let i = 0; i < currentFiles.length; i++) {
      if (i !== indexToRemove) {
        newDt.items.add(currentFiles[i]);
      }
    }

    // Atualiza o estado e o input real
    this.dt = newDt;
    this.inputTarget.files = this.dt.files;

    // Re-renderiza
    this.renderPreviews();
  }

  renderPreviews() {
    this.previewContainerTarget.innerHTML = "";

    if (this.dt.files.length === 0) return;

    // Loop através de todos os arquivos acumulados
    Array.from(this.dt.files).forEach((file, index) => {
      const reader = new FileReader();

      reader.onload = (event) => {
        // Cria o container (reusando as classes CSS para ficar igual ao edit)
        const itemDiv = document.createElement("div");
        itemDiv.classList.add("gallery-item");

        // Cria a imagem
        const img = document.createElement("img");
        img.src = event.target.result;

        // Cria o botão de remover (com ação do Stimulus)
        const removeBtn = document.createElement("button");
        removeBtn.classList.add("btn-delete-photo");
        removeBtn.innerHTML = '<i class="fa-solid fa-times"></i>';
        removeBtn.type = "button"; // Importante para não submeter o form

        // Conecta o clique à função removeFile, passando o índice
        removeBtn.setAttribute("data-action", "click->image-preview#removeFile");
        removeBtn.setAttribute("data-image-preview-index-param", index);

        itemDiv.appendChild(img);
        itemDiv.appendChild(removeBtn);
        this.previewContainerTarget.appendChild(itemDiv);
      }

      reader.readAsDataURL(file);
    });
  }
}
