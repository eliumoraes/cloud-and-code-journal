# Cloud and Code Journal

Um journal técnico para acompanhar minha evolução como desenvolvedor .NET focado em Azure e arquitetura. Este repositório simula um ambiente profissional de forma leve e prática, organizando estudos, projetos, desafios e progresso semanal.

## 📋 Propósito

Este repositório serve como:
- **Journal técnico**: Registro semanal de aprendizado e progresso
- **Portfólio de estudos**: Organização de conteúdos de .NET, Azure e arquitetura
- **Prática profissional**: Simulação de ambiente de trabalho com GitHub Projects
- **Biblioteca de conhecimento**: Snippets, diagramas e projetos práticos

## 📁 Estrutura de Diretórios

```
cloud-and-code-journal/
├── journal/          # Logs semanais de progresso e aprendizado
├── learning/         # Conteúdos de estudo (.NET, Azure, Arquitetura)
├── challenges/       # Exercícios do Exercism, Codewars, etc.
├── projects/         # POCs e projetos reais
├── snippets/         # Trechos de código úteis e reutilizáveis
└── diagrams/         # Diagramas de arquitetura e fluxos
```

### Descrição dos Diretórios

- **journal/**: Entradas semanais documentando o que foi aprendido, desafios enfrentados e próximos passos
- **learning/**: Materiais de estudo, anotações, tutoriais e recursos sobre .NET, Azure e arquitetura
- **challenges/**: Soluções de exercícios de plataformas como Exercism, Codewars, LeetCode, etc.
- **projects/**: Projetos práticos, POCs (Proof of Concept) e implementações reais
- **snippets/**: Códigos úteis, helpers, extensões e utilitários para referência rápida
- **diagrams/**: Diagramas de arquitetura, fluxos de processo e visualizações técnicas

## 🎯 GitHub Project Board

Este repositório utiliza um GitHub Project Board para gerenciar tarefas de forma profissional, simulando o ambiente de trabalho de uma empresa.

### Views do Board

O board possui **4 views principais** para manter foco e organização:

#### 1. **My Work**
Mostra apenas o que você está fazendo **hoje** ou **esta semana**.

**Filtro**: `assignee:@me status:'In progress'`

**Por quê?** Evita olhar para 30 tarefas ao mesmo tempo e mantém foco no que está realmente ativo.

#### 2. **Backlog**
Tudo o que você quer fazer no futuro, mas não precisa olhar agora.

**Ordenação**: `sort: Priority asc`

**Por quê?** Aqui fica tudo o que não deve te atrapalhar durante a semana. Você revisa apenas quando for planejar.

#### 3. **Learning**
Aqui ficam apenas os estudos e preparações:
- .NET
- Azure
- Arquitetura
- Exercism
- Codewars
- Entrevistas

**Filtro**: `label:learning`

**Por quê?** Estudo não é "feature de projeto". É desenvolvimento pessoal. Ter separado evita bagunça mental.

#### 4. **Done**
Tudo o que você completou.

**Filtro**: `status:'Done'`

**Por quê?** Ajuda muito a visualizar progresso, que é algo que motiva e mantém disciplina.

### Campos Customizados

O board utiliza os seguintes campos:

- **Status**: `To do`, `In progress`, `Blocked`, `Done`
- **Priority**: `Low`, `Medium`, `High`
- **Sprint**: `Week 1`, `Week 2`, `Week 3`... (texto livre)
- **Labels**: `learning`, `feature`, `challenge`, `project`, `journal`

## 🔄 Fluxo de Trabalho Semanal

### Segunda-feira - Planejamento
1. Revisar o **Backlog**
2. Selecionar tarefas para a semana (3-5 tarefas é ideal)
3. Mover tarefas selecionadas para **My Work**
4. Definir **Status** como `In progress`
5. Atribuir **Sprint** (ex: `Week 1`)

### Durante a Semana - Execução
1. Trabalhar nas tarefas de **My Work**
2. Atualizar progresso nas issues conforme necessário
3. Quando completar uma tarefa, mudar **Status** para `Done`
4. Tarefas concluídas automaticamente aparecem em **Done**

### Sexta/Sábado - Revisão e Planejamento
1. Revisar **Done** para visualizar progresso da semana
2. Decidir quais tarefas incompletas vão para a próxima semana
3. Atualizar **Sprint** para a próxima semana ou voltar para **Backlog**
4. Planejar a próxima sprint

## 📝 Tipos de Tarefas

O repositório possui templates para diferentes tipos de tarefas:

- **Learning Task**: Para estudos (.NET, Azure, Arquitetura)
- **Challenge Task**: Para Exercism, Codewars, etc.
- **Project Task**: Para POCs e projetos reais
- **Journal Entry**: Para logs semanais

Cada template inclui campos para Status, Priority, Sprint e Labels apropriados.

## 🚀 Como Começar

1. **Criar o GitHub Project Board** (veja seção abaixo)
2. **Configurar os campos customizados** no board
3. **Criar as 4 views** com os filtros especificados
4. **Criar issues** usando os templates disponíveis
5. **Seguir o fluxo semanal** descrito acima

## 📚 Configuração do GitHub Project Board

### Passo 1: Criar o Board
1. Acesse o repositório no GitHub
2. Clique em **Projects** (ou **Projects** no menu superior)
3. Clique em **New project**
4. Escolha **Board** como template
5. Nomeie como "Cloud and Code Journal"

### Passo 2: Configurar Campos Customizados
1. No board, clique em **Settings** (⚙️)
2. Vá em **Fields**
3. Adicione os seguintes campos:
   - **Status** (Single select): `To do`, `In progress`, `Blocked`, `Done`
   - **Priority** (Single select): `Low`, `Medium`, `High`
   - **Sprint** (Text): Campo de texto livre

### Passo 3: Criar Labels
1. No repositório, vá em **Issues** > **Labels**
2. Crie as seguintes labels:
   - `learning` (cor: azul)
   - `feature` (cor: verde)
   - `challenge` (cor: laranja)
   - `project` (cor: roxo)
   - `journal` (cor: amarelo)

### Passo 4: Criar Views
1. No board, clique em **+ Add view**
2. Crie as seguintes views:

**My Work**:
- Filtro: `assignee:@me status:'In progress'`
- Agrupamento: `Status`

**Backlog**:
- Ordenação: `Priority asc`
- Agrupamento: `Priority`

**Learning**:
- Filtro: `label:learning`
- Agrupamento: `Status`

**Done**:
- Filtro: `status:'Done'`
- Agrupamento: `Sprint`

## 💡 Dicas

- Mantenha **My Work** com no máximo 5 tarefas ativas
- Use **Priority** para organizar o Backlog
- Revise **Done** semanalmente para manter motivação
- Use **Labels** consistentemente para facilitar filtros
- Atualize o **journal/** semanalmente com seu progresso

## 📄 Licença

Este é um repositório pessoal para fins de aprendizado e desenvolvimento profissional.

---

**Descrição para GitHub**: Journal técnico para acompanhar evolução como desenvolvedor .NET focado em Azure e arquitetura. Organiza estudos, projetos, desafios e progresso semanal usando GitHub Projects.

