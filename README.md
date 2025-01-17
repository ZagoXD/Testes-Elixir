# Projetos em Elixir e Phoenix

Este repositório contém três projetos básicos criados com Elixir e o framework Phoenix:
1. **API CRUD** - Gerencia tarefas com operações de criação, leitura, atualização e exclusão.
2. **Chat em Tempo Real** - Sistema de chat em tempo real com Phoenix Channels.
3. **API de Autenticação** - Sistema de autenticação com cadastro e login de usuários.
4. **API para Gerenciar Livros para Testes** - Sistema para realização de teste unitários.

## Requisitos
Antes de começar, certifique-se de que você tenha instalado:
- [Elixir](https://elixir-lang.org/install.html)
- [Phoenix](https://hexdocs.pm/phoenix/installation.html)
- [PostgreSQL](https://www.postgresql.org/download/)
- Node.js (para gerenciar dependências front-end)

---

## Instruções Comuns para os Projetos

1. Clone este repositório:
   ```bash
   git clone https://github.com/ZagoXD/Testes-Elixir.git
   cd Testes-Elixir
   ```

2. Instale as dependências:
   ```bash
   mix deps.get
   mix deps.compile
   ```

3. Configure o banco de dados no arquivo `config/dev.exs`, ajustando as credenciais de acesso ao PostgreSQL.

4. Crie e migre o banco de dados (não é necessário para o chat em tempo real):
   ```bash
   mix ecto.create
   mix ecto.migrate
   ```

5. Inicie o servidor:
   ```bash
   mix phx.server
   ```

6. Acesse o projeto no navegador em `http://localhost:4000`.

---

## API CRUD

### Rotas Principais
- **GET** `/api/tasks` - Lista todas as tarefas.
- **POST** `/api/tasks` - Cria uma nova tarefa.
- **PUT** `/api/tasks/:id` - Atualiza uma tarefa existente.
- **DELETE** `/api/tasks/:id` - Exclui uma tarefa.

### Testando a API
Você pode testar as rotas utilizando ferramentas como o Postman ou o cURL ou com o frontend disponível `frontend/index.html`.

---

## Chat em Tempo Real

### Funcionalidades
- Sistema de chat em tempo real utilizando Phoenix Channels.
- Cada usuário deve escolher um nome ao entrar no chat.

### Como Acessar
1. Abra o arquivo `frontend/index.html` no navegador.
2. Digite seu nome de usuário e envie mensagens para interagir com outros usuários conectados.

---

## API de Autenticação

### Funcionalidades
- Sistema autenticação básico feito em Elixir.
- Cadastro e login vinculados à um banco de dados PostgresSQL.

### Como Acessar
1. Abra o arquivo `frontend/index.html` no navegador.
2. Realize o cadastro de um usuário.
3. Realize o login do usuário.
4. É possível checar no console ou no próprio banco de dados se o usuário foi criado e o login efetuado.

---

## Observações
Se encontrar algum erro ou tiver dúvidas:
1. Verifique se o banco de dados PostgreSQL está ativo.
2. Verifique se as dependências foram instaladas corretamente (algumas delas exigem um compilador C para serem instaladas).
3. Verifique os arquivos de configuração (`config/dev.exs`).

## API de Gerenciamento de Livros

### Funcionalidades
- Sistema básico de CRUD para realização de testes.

### Como Acessar
1. Realize os teste com 
   ```bash
   mix test
   ```

## Tabela de comparativos e observações no PDF
