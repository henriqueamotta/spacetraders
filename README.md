# SpaceTraders Marketplace 🚀

<p align="center">
<a href="#english-version">🇺🇸 English Version</a> | <a href="#pt-br-version">🇧🇷 Versão em Português</a>
</p>

---

<div id="english-version"></div>

# 🇺🇸 English Version

An online marketplace built with Ruby on Rails where space enthusiasts can buy and sell intergalactic vehicles, such as starships, droids, and more. Version 2.0 introduces a robust asynchronous architecture, advanced authorization, and a fully responsive Neon/Dark UI.

---

## 📖 Overview

This project is a full-featured web application that simulates a futuristic e-commerce platform. Users can register, list their own products, manage their inventory via a dashboard, browse listings with filters, and complete purchases with a simulated delivery delay. The application follows Ruby on Rails 7 best practices, featuring background jobs, comprehensive testing, and a reactive user interface using Hotwire.

---

## ✨ Key Features

- **Advanced UI/UX**: Visual overhaul with a responsive Dark/Neon theme, custom Navbar, and fluid typography using `clamp()` and `rem`.
- **User Authentication (Devise)**: Secure signup/login with custom fields (Username, First/Last Name).
- **Authorization (Pundit)**: Role-based access control. Users cannot buy their own products; only owners can edit/delete listings.
- **Seller Dashboard**: Inventory management area with toggle between Grid View and List View.
- **Smart Image Upload**: `Cloudinary` + `Active Storage` integration. Custom Stimulus controller for instant previews, cumulative uploads, and individual deletion.
- **Async Background Jobs**: `Redis` and `Sidekiq` simulate delivery logistics. Orders transition from “Processing” to “Delivered” automatically.
- **Order History**: Track past purchases, view detailed summaries, cancel pending orders.
- **Robust Testing**: Full test suite with Minitest for Models, Controllers, and System tests.

---

## 🛠️ Tech Stack

- **Backend:** Ruby `3.3.5`, Rails `7.1.5`
- **Database:** PostgreSQL
- **Frontend:** Hotwire (Turbo & Stimulus), Importmap, Bootstrap 5, SASS, Font Awesome
- **Auth:** Devise, Pundit
- **Background Jobs:** Redis, Sidekiq
- **File Uploads:** Cloudinary & Active Storage
- **Web Server:** Puma

---

## ☝️ Getting Started

### Prerequisites
- Ruby `3.3.5`
- PostgreSQL
- Redis
- Node.js
- A [Cloudinary](https://cloudinary.com/) account

---

### 📁 Installation

**1. Clone the repository:**
```bash
git clone https://github.com/henriqueamotta/spacetraders.git
cd spacetraders
```

**2. Install dependencies:**
```bash
bundle install
```

**3. Set up environment variables:** Create a `.env` file in the project root and add your Cloudinary keys:
```bash
CLOUDINARY_URL="cloudinary://API_KEY:API_SECRET@CLOUD_NAME"
```

**4. Set up the database:**
```bash
rails db:create
rails db:migrate
# Populates the DB with 3 Users and 15 Products (Star Wars themed)
rails db:seed
```

**5. Start the application:** You need to run both the Rails server and Sidekiq (for background jobs).

**Terminal 1 (Web Server):**
```bash
rails server
```

**Terminal 2 (Background Worker):**
```bash
bundle exec sidekiq
```
#### Access the application at http://localhost:3000.
---

<div id="pt-br-version"></div>

# 🇧🇷 Versão em Português

Um marketplace online construído com Ruby on Rails onde entusiastas do espaço podem comprar e vender veículos intergalácticos, como naves estelares, droides e muito mais. A Versão 2.0 introduz uma arquitetura assíncrona robusta, autorização avançada e uma UI Neon/Dark totalmente responsiva.

---

## 📖 Visão Geral

Este projeto é uma aplicação web completa que simula uma plataforma de e-commerce futurista. Usuários podem se cadastrar, listar seus próprios produtos, gerenciar seu inventário através de um painel, navegar por listagens com filtros e realizar compras com simulação de atraso de entrega. A aplicação segue as melhores práticas do Ruby on Rails 7, apresentando background jobs, testes abrangentes e uma interface reativa usando Hotwire.

---
## ✨ Principais Funcionalidades

- **UI/UX Avançada:** Uma reformulação visual completa apresentando um tema Dark/Neon responsivo, Navbar customizada e tipografia fluida usando unidades `clamp()` e `rem`.
- **Autenticação de Usuário:** Registro e login seguros usando `Devise`, incluindo campos personalizados (Username, Nome/Sobrenome).
- **Autorização (Pundit):** Controle de acesso baseado em regras. Usuários não podem comprar seus próprios produtos, e apenas os donos podem editar/excluir seus anúncios.
- **Painel do Vendedor (Dashboard):** Uma área dedicada para vendedores gerenciarem estoque, com alternância entre Visualização em Grade e Lista.
- **Upload de Imagens Inteligente:** Integração com `Cloudinary` e `Active Storage`. Inclui um controlador Stimulus customizado para pré-visualização instantânea, uploads cumulativos e exclusão individual de fotos.
- **Jobs em Segundo Plano (Async)** Implementação de `Redis` e `Sidekiq` para simular a logística de entrega. Pedidos iniciam como "Processando" e atualizam automaticamente para "Entregue" após um tempo, sem bloquear o usuário.
- **Histórico de Pedidos:** Usuários podem rastrear suas compras, ver resumos detalhados e cancelar pedidos (se ainda não entregues).
- **Testes Robustos:** Suíte de testes abrangente usando Minitest cobrindo Modelos, Controllers e fluxos de Sistema (Ponta a Ponta).

---

## 🛠️ Tech Stack
- **Backend:** Ruby `3.3.5`, Rails `7.1.5`
- **Banco de Dados:** PostgreSQL
- **Frontend:** Hotwire (Turbo & Stimulus), Importmap, Bootstrap 5, SASS, Font Awesome
- **Autenticação & Autorização:** Devise, Pundit
- **Background Jobs:** Redis, Sidekiq
- **Upload de Arquivos:** Cloudinary & Active Storage
- **Servidor Web:** Puma

---

## ☝️ Começando

### Pré-requisitos
- Ruby `3.3.5`
- PostgreSQL
- Redis
- Node.js
- Uma conta no [Cloudinary](https://cloudinary.com/)

---
### 📁 Instalação

**1. Clone o repositório:**
```bash
git clone https://github.com/henriqueamotta/spacetraders.git
cd spacetraders
```

**2. Instale as dependências:**
```bash
bundle install
```

**3. Configure as variáveis de ambiente:** Crie um arquivo `.env` na raiz do projeto e adicione suas chaves do Cloudinary:
```bash
CLOUDINARY_URL="cloudinary://API_KEY:API_SECRET@CLOUD_NAME"
```

**4. Configure o banco de dados:**
```bash
rails db:create
rails db:migrate
# Popula o banco com 3 Usuários e 15 Produtos (tema Star Wars)
rails db:seed
```

**5. Inicie a aplicação:** Você precisa rodar tanto o servidor Rails quanto o Sidekiq (para os jobs).

**Terminal 1 (Servidor Web):**
```bash
rails server
```

**Terminal 2 (Worker de Background):**
```bash
bundle exec sidekiq
```
#### Acesse o aplicativo em http://localhost:3000.

---
<p align="center"> Rails app generated with <a href="https://github.com/lewagon/rails-templates">lewagon/rails-templates</a>, created by the <a href="https://www.lewagon.com">Le Wagon coding bootcamp</a> team. </p>
