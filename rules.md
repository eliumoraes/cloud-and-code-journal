# Rules - Cloud and Code Journal

Este arquivo contém as regras e diretrizes que a IA deve seguir ao ajudar neste repositório.

**Última atualização**: 2025-11-29

---

## 🎯 Foco Principal

- **Tecnologias**: .NET (C#), Azure Cloud Services, Arquitetura de Software
- **Objetivo**: Acompanhar evolução como desenvolvedor .NET focado em Azure e arquitetura
- **Contexto**: Simular ambiente profissional de forma leve e prática

---

## ⚠️ Regras Importantes (Resumo)

1. **Nunca assumir que algo está finalizado**: Sempre indicar quando objetivos foram concluídos e pedir verificação
2. **Sempre incluir datas**: Sempre adicionar data de criação/atualização em arquivos e documentos (obter via PowerShell: `Get-Date -Format "yyyy-MM-dd"`)
3. **Seguir arquivos .md**: Sempre ler e seguir orientações em README.md e rules.md
4. **Atualizar documentação**: Ao finalizar trabalho, atualizar README ou rules.md se necessário
5. **Sempre solicitar aprovação para commits**: Nunca fazer commit e push sem aprovação explícita do usuário
6. **Proteger informações sensíveis**: Nunca commitar tokens, senhas ou informações privadas (usar pasta `.secrets/`)
7. **NUNCA modificar atividades com Status "Done"**: Issues marcadas como "Done" não devem ser modificadas. Elas servem como histórico.

---

## 📅 Regras de Data

### ⚠️ OBRIGATÓRIO: Sempre Incluir Datas

**SEMPRE adicionar datas em:**
- Arquivos criados ou modificados (data de criação/atualização)
- Issues criadas ou atualizadas
- Documentos de aprendizado
- Entradas de journal
- Qualquer arquivo que tenha contexto temporal

### Como Obter Data Atual

**SEMPRE usar PowerShell para obter a data atual:**

```powershell
# Comando para obter data atual no formato padrão
Get-Date -Format "yyyy-MM-dd"
```

**Formato padrão**: `yyyy-MM-dd` (exemplo: 2025-11-24)

### Quando Usar Datas

- **Data de criação**: Data atual quando o arquivo é criado
- **Data de atualização**: Data atual quando o arquivo é modificado (sempre atualizar)
- **Datas em journal**: Usar datas reais da semana correspondente
- **Datas em issues**: Usar datas reais do período da semana

**⚠️ IMPORTANTE**: 
- Nunca usar datas futuras ou datas incorretas
- Sempre verificar com `Get-Date` antes de escrever datas
- Nunca assumir ou inventar datas - sempre obter via comando PowerShell

---

## 📝 Regras de Anotações (Journal)

### Estrutura de Entradas no Journal

```markdown
# Semana [N] - [Data Inicial] a [Data Final]

**Data de Criação**: YYYY-MM-DD
**Última Atualização**: YYYY-MM-DD

## 🎯 Objetivos da Semana
## ✅ Conquistas
## 📚 Aprendizados
## 🚧 Desafios Enfrentados
## 🔄 Próximos Passos
## 📊 Métricas
```

### Padrões de Nomenclatura

- Arquivos de journal: `week-[N]-[YYYY-MM-DD].md`
- Exemplo: `week-1-2025-11-18.md`

---

## 💬 Regras de Como a IA Deve Responder

### Tom e Estilo

- **Profissional mas acessível**: Use linguagem técnica quando apropriado, mas explique conceitos complexos
- **Direto e objetivo**: Seja claro e evite rodeios
- **Construtivo**: Sempre ofereça soluções práticas e acionáveis
- **Focado em aprendizado**: Priorize explicações que ajudem no crescimento técnico

### Estilo de Narração (PREFERIDO pelo Usuário)

**⚠️ IMPORTANTE**: O usuário prefere um estilo de narração descritivo e didático que facilita a compreensão. Use este estilo **de vez em quando**, especialmente ao explicar código de testes, mocks, e configurações.

**Exemplos do estilo preferido:**

**Em Português:**
- "Configurar mock para que quando chamar ProcessarAsync, retorne..."
- "Configurar mock para que quando chamar BuscarAsync com 1, retorne..."
- "Configurar mock para que quando chamar ProcessarAsync com qualquer string, retorne..."
- "Verificar que BuscarAsync foi chamado com 1 uma vez"

**Em Inglês:**
- "Setup mock so that when ProcessarAsync is called, return..."
- "Setup mock so that when BuscarAsync is called with 1, return..."
- "Setup mock so that when ProcessarAsync is called with any string, return..."
- "Verify that BuscarAsync was called with 1 once"

**Quando usar:**
- ✅ Ao explicar código de testes (xUnit, Moq, etc.)
- ✅ Ao explicar configuração de mocks e stubs
- ✅ Ao explicar verificações (Verify, Assert, etc.)
- ✅ Quando o usuário parece confuso sobre o que o código faz
- ✅ Ao introduzir novos conceitos de teste

**Como usar:**
- Use frases descritivas que explicam a **intenção** do código
- Use "para que quando..." ou "so that when..." para conectar ação e resultado
- Combine com explicações técnicas quando necessário
- Não precisa usar em TODAS as explicações, mas use **de vez em quando** para facilitar compreensão

**Exemplo completo:**
```csharp
mockService
    .Setup(x => x.ProcessarAsync())
    .ReturnsAsync("dados");
```

**Explicação com estilo preferido:**
> "Configurar mock para que quando chamar ProcessarAsync, retorne 'dados'."

**Explicação técnica (também válida, mas menos preferida):**
> "Setup do mock que retorna 'dados' quando ProcessarAsync é chamado."

### Quando Ajudar com Código

- **Sempre explique o "porquê"**: Não apenas mostre código, explique a lógica
- **Mencione boas práticas**: Indique padrões .NET, convenções C# e práticas Azure
- **Sugira melhorias**: Quando apropriado, indique alternativas ou otimizações
- **Contexto Azure**: Sempre considere implicações de cloud quando relevante

### Quando Ajudar com Estudos

- **Estruture o aprendizado**: Organize conteúdos de forma progressiva
- **Forneça recursos**: Indique documentação oficial, tutoriais e exemplos práticos
- **Crie conexões**: Relacione novos conceitos com conhecimentos já adquiridos
- **Pratique ativa**: Sugira exercícios práticos e desafios relacionados

---

## 🔧 Convenções de Commit

### Formato: Conventional Commits

```
<tipo>(<escopo>): <descrição curta>

<corpo opcional>
```

### Tipos de Commit

- `feat`: Nova funcionalidade
- `fix`: Correção de bug
- `docs`: Mudanças na documentação
- `learning`: Conteúdo de aprendizado adicionado
- `challenge`: Solução de desafio (Exercism, Codewars, etc)
- `journal`: Entrada no journal semanal
- `project`: Mudanças em projetos/POCs
- `refactor`, `test`, `chore`, `style`: Padrões convencionais

### Processo de Commit e Push

**IMPORTANTE**: A IA deve sempre seguir este processo:

1. **Sugerir mensagem de commit** (formato Conventional Commits)
2. **Solicitar aprovação explícita** ("Posso fazer o commit e push com esta mensagem?")
3. **Aguardar confirmação** (NUNCA fazer sem aprovação)
4. **Executar após aprovação**: `git add`, `git commit`, `git push`

### Regras Adicionais

- **Mensagens em português**: Descreva em português brasileiro
- **Descrição curta**: Máximo 72 caracteres na primeira linha
- **Corpo opcional**: Use bullet list para múltiplas mudanças relacionadas
- **Um commit por mudança lógica**: Não misture múltiplas mudanças não relacionadas

---

## 💻 Padrões de Código .NET

### Convenções C#

- **Nomenclatura**: Classes/Métodos/Propriedades: `PascalCase` | Campos privados: `_camelCase` | Variáveis: `camelCase`
- **Organização**: Namespaces apropriados, `using` no topo, ordenar membros
- **Documentação**: XML comments para APIs públicas

### Padrões Azure

- **Nomenclatura**: Seguir [Azure naming conventions](https://docs.microsoft.com/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging)
- **Configuração**: `appsettings.json` e Azure Key Vault para secrets
- **Logging**: `ILogger` e Application Insights
- **Resiliência**: Retry, circuit breaker, timeout patterns

### Arquitetura

- **SOLID**: Aplicar princípios sempre que possível
- **Clean Architecture**: Camadas bem definidas quando apropriado
- **Dependency Injection**: Usar DI container do .NET
- **Async/Await**: Preferir operações assíncronas para I/O

---

## 📚 Estrutura de Conteúdo

### ⚠️ Regra: Economizar Arquivos .md

**IMPORTANTE**: Não criar arquivos .md desnecessários. Focar apenas no essencial:
- ✅ Arquivos de aprendizado importantes (conteúdo técnico relevante)
- ✅ Journal entries semanais
- ✅ README quando necessário
- ❌ **NÃO criar**: Arquivos de resumo, revisão, checklist temporários, etc.
- ❌ **NÃO criar**: Múltiplos arquivos para documentar o mesmo trabalho

**Princípio**: Se a informação pode estar em uma issue ou em um arquivo existente, não criar novo arquivo.

### Arquivos de Aprendizado (`learning/`)

**Estilo de Trabalho Progressivo**: Ao trabalhar em atividades de aprendizado (issues), criar e evoluir documentos progressivamente:

1. **Documento Principal**: Um arquivo principal com o conteúdo técnico (ex: `async-await-introducao.md`)
2. **Documento de Progresso**: Um arquivo para acompanhar o progresso da atividade (ex: `async-await-progresso.md`)
   - Registra respostas do usuário
   - Acompanha status dos tópicos
   - Documenta dúvidas e resoluções
   - Lista próximos passos

**Princípio**: Máximo 2-3 documentos por atividade/issue:
- ✅ Documento principal (conteúdo técnico)
- ✅ Documento de progresso (acompanhamento)
- ✅ Documento adicional apenas se necessário (ex: exemplos práticos separados)

**Estrutura sugerida para documento principal:**

```markdown
# [Tópico]

**Data de Criação**: YYYY-MM-DD
**Última Atualização**: YYYY-MM-DD

## Objetivo
## Conceitos
## Exemplos Práticos
## Recursos
## Próximos Passos
```

**Estrutura sugerida para documento de progresso:**

```markdown
# Progresso: [Título da Atividade] (Issue #X)

**Data de Criação**: YYYY-MM-DD
**Última Atualização**: YYYY-MM-DD
**Issue**: #X

## Status dos Tópicos
## Atividades Concluídas
## Respostas Registradas
## Dúvidas e Resoluções
## Próximos Passos
```

### Challenges (`challenges/`)

- **Estrutura**: `challenges/[plataforma]/[exercicio]/`
- **Incluir**: README explicando problema e solução, código comentado
- **Formato**: Problema | Solução | Análise | Aprendizados

---

## 📋 Regras para GitHub Project Board

### 👁️ Visualizar Issue/Atividade

**Quando o usuário pedir para visualizar uma atividade/issue, a IA deve:**

1. **Identificar a issue solicitada:**
   - Por número: `#8`, `issue 8`, `atividade 8`
   - Por título: buscar por palavras-chave no título
   - Por contexto: Sprint, Priority, Status, Label

2. **Usar GitHub CLI para visualizar:**
   ```powershell
   # Visualizar issue por número
   gh issue view <número> --json number,title,body,labels,state,assignees
   
   # Visualizar issue com todos os campos
   gh issue view <número> --json number,title,body,labels,state,assignees,createdAt,updatedAt
   
   # Listar issues com filtros
   gh issue list --state open --json number,title,labels,state
   ```

3. **Apresentar informações de forma organizada:**
   - Número e título da issue
   - Status atual (To do, In progress, Blocked, Done)
   - Priority (High, Medium, Low)
   - Sprint (Week 1, 2, 3, 4)
   - Labels aplicadas
   - Assignee
   - Data de criação
   - Conteúdo do body (resumido se muito longo)
   - Links relevantes (se houver)

4. **Verificar campos no Project Board:**
   - Se o usuário pedir para verificar campos, mencionar que Priority, Sprint, Status e Labels são FIELDS no Project Board
   - Os campos no body são apenas documentação
   - Para verificar campos reais, usar: `gh api graphql` ou verificar no board manualmente

5. **Formato de apresentação sugerido:**
   ```markdown
   ## Issue #<número>: <título>
   
   **Status**: <status>
   **Priority**: <priority>
   **Sprint**: <sprint>
   **Labels**: <labels>
   **Assignee**: <assignee>
   **Data de Criação**: <data>
   
   ### Conteúdo:
   [resumo ou conteúdo completo do body]
   ```

**Exemplo de comando completo:**
```powershell
gh issue view 8 --json number,title,body,labels,state,assignees,createdAt,updatedAt | ConvertFrom-Json | Format-List
```

### ⚡ Resumo Rápido: Campos Obrigatórios

**TODAS as issues DEVEM ter estes FIELDS configurados NO PROJECT BOARD:**

| Campo | Tipo | Valores | Onde Configurar |
|-------|------|---------|----------------|
| **Label** | Field | `learning`, `challenge`, `project`, `journal`, `feature` | Project Board → Issue → Labels |
| **Priority** | Field | `High`, `Medium`, `Low` | Project Board → Issue → Edit fields |
| **Sprint** | Field | `Week 1`, `Week 2`, `Week 3`, `Week 4` | Project Board → Issue → Edit fields |
| **Status** | Field | `To do`, `In progress`, `Blocked`, `Done` | Project Board → Issue → Edit fields |
| **Assignee** | Field | @me | Project Board → Issue → Assignees |
| **Data de Criação** | Body | `YYYY-MM-DD` | Body da issue (primeira linha) |

**⚠️ CRÍTICO**: Fields no Project Board são independentes do body. Sempre configurar nos FIELDS do board!

**📖 Para processo completo**: Veja seções "Processo Completo: Criar Nova Issue" e "Processo Completo: Editar Issue Existente" abaixo.

---

### Nomenclatura de Títulos

- ❌ **NÃO inclua prefixos**: `[LEARNING]`, `[CHALLENGE]`, etc.
- ❌ **NÃO inclua número da semana**: `Semana X` ou `Week X` no título
- ✅ **Use apenas título descritivo**: O label identifica o tipo, o Sprint identifica a semana

**Exemplos corretos**: "Auto-avaliação Técnica .NET e Azure", "Exercism - TwoFer", "POC: Azure App Service + API REST"

### Campos Obrigatórios em TODAS as Issues

**⚠️ REGRA CRÍTICA: TODAS as issues DEVEM ter os seguintes CAMPOS (FIELDS) configurados NO PROJECT BOARD:**

**⚠️ ATENÇÃO: Priority, Status, Labels e Sprint são FIELDS no Project Board, NÃO apenas no body!**

1. **Label** (field obrigatório): Aplicar label apropriada no Project Board (`learning`, `challenge`, `project`, `journal`, `feature`)
2. **Sprint** (field obrigatório): Campo customizado no Project Board no formato: `Week 1`, `Week 2`, etc.
3. **Priority** (field obrigatório): Campo customizado no Project Board: `High` | `Medium` | `Low`
4. **Status** (field obrigatório): Campo customizado no Project Board: `To do` | `In progress` | `Blocked` | `Done`
5. **Assignee**: Sempre você mesmo (@me) - configurar no Project Board
6. **Data de Criação** (no body): Sempre no início do body: `**Data de Criação**: YYYY-MM-DD` (obter via PowerShell)

**⚠️ CRÍTICO**: 
- **Priority, Status, Labels e Sprint DEVEM estar configurados como FIELDS no Project Board**
- **NÃO é no body que precisa ajustar - é nos FIELDS do Project Board**
- Não basta ter no body da issue - os campos customizados do board precisam estar preenchidos
- O body da issue serve apenas para documentação/histórico
- Para visualização e organização no board, os FIELDS são obrigatórios

**Formato padrão no body da issue (para documentação):**
```markdown
**Data de Criação**: YYYY-MM-DD

[conteúdo da issue]

---
**Status**: To do
**Priority**: High
**Sprint**: Week 1
```

### 📝 Processo Completo: Criar Nova Issue

**Passo a passo detalhado para criar uma issue com todos os campos obrigatórios:**

#### 1. Preparação
- [ ] Identificar qual Week estamos: `Get-Date -Format "yyyy-MM-dd"` e calcular Week atual
- [ ] Verificar carga da Week (máximo recomendado: Week 1 = 5-6, Week 2-3 = 6-7, Week 4+ = 7-8)
- [ ] Decidir Priority baseado na importância e urgência
- [ ] Decidir qual Week adicionar (considerar dependências e carga)

#### 2. Criar a Issue
- [ ] Criar issue usando template apropriado (learning, challenge, project, journal)
- [ ] **Título**: Sem prefixos `[LEARNING]`, sem número de semana, apenas descrição clara
- [ ] **Body**: Adicionar no início: `**Data de Criação**: YYYY-MM-DD` (obter via PowerShell)
- [ ] **Body**: Adicionar no final (para documentação):
  ```markdown
  ---
  **Status**: To do
  **Priority**: [High|Medium|Low]
  **Sprint**: Week [1|2|3|4]
  ```

#### 3. Configurar Fields no Project Board (CRÍTICO)
**⚠️ A IA deve configurar automaticamente via CLI (veja seção "Configurar Fields via CLI" abaixo)**

- [ ] **Priority**: Configurar via GraphQL mutation (usar IDs fornecidos)
- [ ] **Sprint**: Configurar via GraphQL mutation (usar IDs fornecidos)
- [ ] **Status**: Configurar via GraphQL mutation (usar IDs fornecidos)
- [ ] **Label**: Configurar via `gh issue edit --add-label`
- [ ] **Assignee**: Configurar via `gh issue edit --add-assignee`
- [ ] **Verificar**: Confirmar que todos os fields foram configurados corretamente

#### 4. Verificação Final
- [ ] Confirmar que Label aparece no board
- [ ] Confirmar que Priority aparece no board
- [ ] Confirmar que Sprint aparece no board
- [ ] Confirmar que Status aparece no board
- [ ] Confirmar que Assignee está configurado
- [ ] Verificar distribuição da Week (não sobrecarregada)

### 📝 Processo Completo: Editar Issue Existente

**Quando editar uma issue (Status != "Done"):**

#### 1. Atualizar Body (se necessário)
- [ ] Atualizar conteúdo da issue
- [ ] Atualizar `**Data de Criação**` se for mudança significativa (ou manter original)
- [ ] Atualizar campos no final do body (Status, Priority, Sprint) para documentação

#### 2. Atualizar Fields no Project Board (CRÍTICO)
- [ ] Acessar o Project Board
- [ ] Encontrar a issue no board
- [ ] Clicar na issue ou usar menu → "Edit fields"
- [ ] Atualizar **Priority** se necessário
- [ ] Atualizar **Sprint** se necessário (reorganização)
- [ ] Atualizar **Status** conforme progresso (`To do` → `In progress` → `Done`)
- [ ] Atualizar **Label** se o tipo mudou
- [ ] Salvar alterações
- [ ] **Verificar**: Fields atualizados aparecem no board

#### 3. Atualizar via CLI (Opcional - apenas Priority e Sprint)
- [ ] Copiar template: `scripts/update-project-fields.ps1.template` → `scripts/update-project-fields.ps1`
- [ ] Configurar IDs do projeto e campos no script (veja seção "Atualizar Fields via CLI" abaixo)
- [ ] Adicionar/atualizar issue no mapeamento `$issuesConfig`
- [ ] Obter `itemId` se for issue nova (via GraphQL - veja instruções abaixo)
- [ ] Adicionar `itemId` no mapeamento `$issueItemIds`
- [ ] Executar: `.\scripts\update-project-fields.ps1`
- [ ] Verificar resultados no board
- [ ] **Após uso**: Remover ou limpar o script (não commitar scripts com dados específicos)

**⚠️ IMPORTANTE**: 
- Issues com Status "Done" **NUNCA** devem ser modificadas
- Sempre atualizar fields no Project Board, não apenas no body
- Body serve apenas para documentação/histórico

### ⚠️ CRÍTICO: Campos DEVEM estar como FIELDS no Project Board

**Os campos Priority, Sprint, Status e Labels DEVEM estar configurados como FIELDS no Project Board:**

1. **Labels** (field): Aplicar label diretamente na issue (aparece como field no board)
2. **Priority** (field): Campo customizado no Project Board - configurar manualmente
3. **Sprint** (field): Campo customizado no Project Board - configurar manualmente  
4. **Status** (field): Campo customizado no Project Board - configurar manualmente

**Por quê?** 
- O GitHub Project Board usa campos customizados (fields) que são independentes do body da issue
- Ter no body é apenas documentação - os FIELDS do board são o que realmente importa para visualização
- Sem os fields configurados, as issues não aparecem organizadas corretamente no board

**Como configurar os fields no board (método manual):**
1. Acesse o Project Board no GitHub
2. Encontre a issue no board
3. Clique na issue ou use o menu (três pontinhos) → "Edit fields"
4. Configure os fields: **Priority**, **Sprint**, **Status**
5. Aplique **Label** diretamente na issue
6. Configure **Assignee** como @me
7. Salve as alterações
8. **Verificar**: Os fields devem aparecer visualmente nas colunas do board (Priority, Sprint, Status, Labels)

**Alternativa: Usar script PowerShell** (veja seção "Atualizar Fields via CLI" abaixo)

**⚠️ IMPORTANTE**: Os fields no Project Board estão independentes do body da issue. Se os fields estiverem errados no board, eles precisam ser ajustados manualmente no board, não apenas no body.

### 🔧 Atualizar Fields via CLI (Script PowerShell Template)

**Os fields podem ser atualizados via CLI usando o template PowerShell:**

1. **Localização do template**: `scripts/update-project-fields.ps1.template`
2. **Token necessário**: Token do GitHub em `.secrets/github-token.txt` (primeira linha) com permissões `read:project` e `write:project`
3. **Como usar**:
   ```powershell
   # 1. Copiar template para script de trabalho
   Copy-Item scripts/update-project-fields.ps1.template scripts/update-project-fields.ps1
   
   # 2. Editar o script e configurar IDs (veja abaixo)
   # 3. Executar o script
   .\scripts\update-project-fields.ps1
   
   # 4. Após uso, remover o script (não commitar)
   Remove-Item scripts/update-project-fields.ps1
   ```

**⚠️ IMPORTANTE**: 
- O template é genérico e pode ser reutilizado
- O script de trabalho (`update-project-fields.ps1`) contém dados específicos e **NÃO deve ser commitado**
- Sempre copie do template e remova após uso

**O template:**
- Carrega automaticamente o token de `.secrets/github-token.txt` (primeira linha)
- Atualiza os fields **Priority** e **Sprint** para todas as issues configuradas
- Usa GraphQL API do GitHub Projects v2
- Mostra progresso e resumo de sucessos/erros

**Para usar o template:**
1. Copiar `scripts/update-project-fields.ps1.template` → `scripts/update-project-fields.ps1`
2. Configurar IDs do projeto e campos (obter via GraphQL - veja abaixo)
3. Adicionar issues no mapeamento `$issuesConfig` com Priority e Sprint
4. Obter os `itemId` das issues no projeto (via GraphQL - veja abaixo)
5. Adicionar os `itemId` no mapeamento `$issueItemIds`
6. Executar o script
7. **Remover o script após uso** (não commitar)

**Obter IDs necessários:**
```powershell
# Configurar token
$env:GH_TOKEN = (Get-Content .secrets/github-token.txt | Select-String -Pattern '^ghp_' | ForEach-Object { $_.Line.Trim() })

# Obter ID do projeto
gh api graphql -f query='query { viewer { projectsV2(first: 10) { nodes { id title number } } } }'

# Obter IDs dos campos
gh api graphql -f query='query { node(id: "PROJECT_ID") { ... on ProjectV2 { fields(first: 20) { nodes { ... on ProjectV2Field { id name } ... on ProjectV2SingleSelectField { id name options { id name } } } } } } }'

# Obter IDs das issues no projeto
gh api graphql -f query='query { node(id: "PROJECT_ID") { ... on ProjectV2 { items(first: 100) { nodes { id content { ... on Issue { number title } } } } } } }'
```

**⚠️ IMPORTANTE**: 
- O script atualiza apenas Priority e Sprint
- Status e Labels devem ser configurados manualmente ou via outros métodos
- Sempre verificar os resultados no Project Board após executar o script

### 🚀 Configurar Fields via CLI (Método Direto - PREFERIDO)

**A IA deve SEMPRE configurar os fields via CLI ao criar ou editar issues automaticamente.**

#### 📋 IDs do Projeto (Constantes - Não Mudam)

```powershell
# IDs fixos do projeto "Cloud and Code Journal" - USAR SEMPRE
$PROJECT_ID = "PVT_kwHOASlIzM4BI0d-"
$PRIORITY_FIELD_ID = "PVTSSF_lAHOASlIzM4BI0d-zg5KumI"
$SPRINT_FIELD_ID = "PVTF_lAHOASlIzM4BI0d-zg5KurQ"
$STATUS_FIELD_ID = "PVTSSF_lAHOASlIzM4BI0d-zg5KteU"

# Priority Options IDs - Mapear conforme Priority desejada
$PRIORITY_IDS = @{
    "Low" = "3ef78ad9"
    "Medium" = "12352b70"
    "High" = "bf4198d7"
}

# Status Options IDs - Mapear conforme Status desejado
$STATUS_IDS = @{
    "To do" = "f75ad846"
    "In progress" = "47fc9ee4"
    "Blocked" = "be9755f8"
    "Done" = "98236657"
}
```

#### 🔧 Processo Genérico: Configurar Fields de Qualquer Issue

**Passo a passo genérico que funciona para qualquer issue:**

1. **Carregar token:**
   ```powershell
   $env:GH_TOKEN = (Get-Content .secrets/github-token.txt -First 1).Trim()
   ```

2. **Obter itemId da issue no projeto:**
   ```powershell
   # Substituir $issueNumber pela variável com o número da issue
   $result = gh api graphql -f query='query { node(id: "PVT_kwHOASlIzM4BI0d-") { ... on ProjectV2 { items(first: 100) { nodes { id content { ... on Issue { number } } } } } } }' | ConvertFrom-Json
   $itemId = ($result.data.node.items.nodes | Where-Object { $_.content.number -eq $issueNumber }).id
   ```

3. **Configurar Priority (usar variável $priority):**
   ```powershell
   # $priority deve ser: "Low", "Medium" ou "High"
   $priorityOptionId = $PRIORITY_IDS[$priority]
   $priorityMutation = "mutation { updateProjectV2ItemFieldValue(input: { projectId: `"PVT_kwHOASlIzM4BI0d-`" itemId: `"$itemId`" fieldId: `"PVTSSF_lAHOASlIzM4BI0d-zg5KumI`" value: { singleSelectOptionId: `"$priorityOptionId`" } }) { projectV2Item { id } } }"
   gh api graphql -f query=$priorityMutation
   ```

4. **Configurar Sprint (usar variável $sprint):**
   ```powershell
   # $sprint deve ser: "Week 1", "Week 2", "Week 3" ou "Week 4"
   $sprintMutation = "mutation { updateProjectV2ItemFieldValue(input: { projectId: `"PVT_kwHOASlIzM4BI0d-`" itemId: `"$itemId`" fieldId: `"PVTF_lAHOASlIzM4BI0d-zg5KurQ`" value: { text: `"$sprint`" } }) { projectV2Item { id } } }"
   gh api graphql -f query=$sprintMutation
   ```

5. **Configurar Status (usar variável $status):**
   ```powershell
   # $status deve ser: "To do", "In progress", "Blocked" ou "Done"
   $statusOptionId = $STATUS_IDS[$status]
   $statusMutation = "mutation { updateProjectV2ItemFieldValue(input: { projectId: `"PVT_kwHOASlIzM4BI0d-`" itemId: `"$itemId`" fieldId: `"PVTSSF_lAHOASlIzM4BI0d-zg5KteU`" value: { singleSelectOptionId: `"$statusOptionId`" } }) { projectV2Item { id } } }"
   gh api graphql -f query=$statusMutation
   ```

6. **Configurar Label (usar variável $label):**
   ```powershell
   # $label deve ser: "learning", "challenge", "project", "journal", "feature"
   gh issue edit $issueNumber --add-label $label
   ```

7. **Configurar Assignee:**
   ```powershell
   gh issue edit $issueNumber --add-assignee eliumoraes
   ```

#### 🎯 Como Determinar os Valores das Variáveis

**Ao criar ou editar uma issue, a IA deve determinar:**

- **$issueNumber**: Número da issue (obtido do output de `gh issue create` ou fornecido pelo usuário)
- **$priority**: Baseado na importância (High/Medium/Low) - verificar no body da issue ou contexto
- **$sprint**: Baseado na semana planejada (Week 1/2/3/4) - verificar no body da issue ou contexto
- **$status**: Geralmente "To do" para novas issues, ou conforme contexto para edições
- **$label**: Baseado no tipo de atividade (learning/challenge/project/journal/feature) - verificar no contexto

#### 📝 Exemplo Genérico: Função Reutilizável

```powershell
function Set-IssueFields {
    param(
        [int]$IssueNumber,
        [string]$Priority,      # "Low", "Medium", "High"
        [string]$Sprint,        # "Week 1", "Week 2", "Week 3", "Week 4"
        [string]$Status,         # "To do", "In progress", "Blocked", "Done"
        [string]$Label          # "learning", "challenge", "project", "journal", "feature"
    )
    
    # Carregar token
    $env:GH_TOKEN = (Get-Content .secrets/github-token.txt -First 1).Trim()
    
    # IDs constantes
    $PROJECT_ID = "PVT_kwHOASlIzM4BI0d-"
    $PRIORITY_FIELD_ID = "PVTSSF_lAHOASlIzM4BI0d-zg5KumI"
    $SPRINT_FIELD_ID = "PVTF_lAHOASlIzM4BI0d-zg5KurQ"
    $STATUS_FIELD_ID = "PVTSSF_lAHOASlIzM4BI0d-zg5KteU"
    
    $PRIORITY_IDS = @{
        "Low" = "3ef78ad9"
        "Medium" = "12352b70"
        "High" = "bf4198d7"
    }
    
    $STATUS_IDS = @{
        "To do" = "f75ad846"
        "In progress" = "47fc9ee4"
        "Blocked" = "be9755f8"
        "Done" = "98236657"
    }
    
    # Obter itemId
    $result = gh api graphql -f query="query { node(id: `"$PROJECT_ID`") { ... on ProjectV2 { items(first: 100) { nodes { id content { ... on Issue { number } } } } } } }" | ConvertFrom-Json
    $itemId = ($result.data.node.items.nodes | Where-Object { $_.content.number -eq $IssueNumber }).id
    
    if (-not $itemId) {
        Write-Host "Erro: Issue #$IssueNumber não encontrada no projeto" -ForegroundColor Red
        return
    }
    
    # Configurar Priority
    $priorityOptionId = $PRIORITY_IDS[$Priority]
    $priorityMutation = "mutation { updateProjectV2ItemFieldValue(input: { projectId: `"$PROJECT_ID`" itemId: `"$itemId`" fieldId: `"$PRIORITY_FIELD_ID`" value: { singleSelectOptionId: `"$priorityOptionId`" } }) { projectV2Item { id } } }"
    gh api graphql -f query=$priorityMutation | Out-Null
    
    # Configurar Sprint
    $sprintMutation = "mutation { updateProjectV2ItemFieldValue(input: { projectId: `"$PROJECT_ID`" itemId: `"$itemId`" fieldId: `"$SPRINT_FIELD_ID`" value: { text: `"$Sprint`" } }) { projectV2Item { id } } }"
    gh api graphql -f query=$sprintMutation | Out-Null
    
    # Configurar Status
    $statusOptionId = $STATUS_IDS[$Status]
    $statusMutation = "mutation { updateProjectV2ItemFieldValue(input: { projectId: `"$PROJECT_ID`" itemId: `"$itemId`" fieldId: `"$STATUS_FIELD_ID`" value: { singleSelectOptionId: `"$statusOptionId`" } }) { projectV2Item { id } } }"
    gh api graphql -f query=$statusMutation | Out-Null
    
    # Configurar Label
    gh issue edit $IssueNumber --add-label $Label | Out-Null
    
    # Configurar Assignee
    gh issue edit $IssueNumber --add-assignee eliumoraes | Out-Null
    
    Write-Host "✓ Fields configurados para Issue #$IssueNumber" -ForegroundColor Green
}

# Uso:
# Set-IssueFields -IssueNumber 42 -Priority "High" -Sprint "Week 1" -Status "To do" -Label "learning"
```

#### ⚠️ Requisitos

- **Token do GitHub**: Deve estar em `.secrets/github-token.txt` (primeira linha) com permissões `read:project` e `write:project`
- **GitHub CLI**: Deve estar instalado e autenticado
- **Token configurado**: `$env:GH_TOKEN` deve ser configurado antes de usar GraphQL

#### 🎯 Regra para a IA

**SEMPRE que criar ou editar uma issue, a IA deve:**

1. ✅ **Determinar os valores** das variáveis ($priority, $sprint, $status, $label) baseado no contexto
2. ✅ **Obter o número da issue** (do output de `gh issue create` ou fornecido)
3. ✅ **Obter o itemId** da issue no projeto
4. ✅ **Configurar todos os fields** via CLI usando os IDs constantes fornecidos
5. ✅ **Verificar** se os campos foram configurados corretamente

**NÃO deixar para o usuário configurar manualmente no board!**

### ⚠️ Identificar Week Atual ao Criar Nova Atividade

**IMPORTANTE**: Ao criar nova atividade, SEMPRE identificar qual Week estamos e qual Week faz sentido adicionar:

1. **Obter data atual**: `Get-Date -Format "yyyy-MM-dd"`
2. **Identificar Week atual**: 
   - Hoje (24/11/2025) = Week 1
   - Calcular Week baseado na data de início do projeto
3. **Decidir qual Week adicionar**: Considerar:
   - Prioridade da atividade
   - Carga atual da Week
   - Dependências com outras atividades
4. **Reorganizar conforme necessário**: Ao adicionar atividades, verificar distribuição e reorganizar se necessário

### ⚠️ Evitar Sobrecarga em Sprints

**IMPORTANTE**: Ao distribuir issues por Sprint, verificar carga de trabalho:

- **Week 1**: Máximo 5-6 issues (início facilitado)
- **Week 2-3**: Máximo 6-7 issues (ritmo gradual)
- **Week 4+**: Máximo 7-8 issues (ritmo estabelecido)

**Se uma Sprint tiver mais issues que o recomendado:**
- Mover issues de prioridade menor para Sprint seguinte
- Distribuir melhor entre semanas
- Considerar que algumas issues podem ser feitas em paralelo

**Ao adicionar nova atividade:**
- Verificar carga da Week atual
- Se sobrecarregada, adicionar em Week seguinte
- Reorganizar distribuição se necessário

### Dicas Importantes

- **Sempre atribua para você**: Garante que apareça em "My Work"
- **Use Priority consistentemente**: Facilita ordenação
- **Atualize Status regularmente**: Mantém board atualizado
- **Use Sprint para planejamento**: Agrupa tarefas por semana
- **⚠️ NUNCA modificar atividades "Done"**: Issues concluídas servem como histórico
- **Sempre verificar campos obrigatórios**: Antes de considerar uma issue completa, verificar se tem Label, Sprint, Priority, Status e Data de Criação no body E no Project Board
- **Verificar sobrecarga**: Antes de finalizar distribuição, contar issues por Sprint e redistribuir se necessário

---

## 🔐 Segurança e Tokens

### Token do GitHub

- **Localização**: `.secrets/github-token.txt` (não commitado)
- **Uso**: Configurar campos no GitHub Project Board via API
- **Permissões necessárias**: `read:project`, `write:project`
- **Segurança**: Nunca commitar, revogar se comprometido, usar tokens com expiração

**Formato do arquivo `.secrets/github-token.txt`:**
```
ghp_SEU_TOKEN_AQUI
# GitHub Personal Access Token
# (comentários opcionais abaixo)
```

**⚠️ IMPORTANTE**: O token deve estar na **primeira linha** do arquivo, começando com `ghp_`

**Como usar o token:**
- O script `scripts/update-project-fields.ps1` carrega automaticamente o token da primeira linha
- Para usar manualmente: `$env:GH_TOKEN = (Get-Content .secrets/github-token.txt -First 1).Trim()`

**Links**: [Gerenciar tokens](https://github.com/settings/tokens) | [Criar novo token](https://github.com/settings/tokens/new)

---

## 📖 Recursos de Referência

- [.NET Documentation](https://docs.microsoft.com/dotnet/)
- [Azure Documentation](https://docs.microsoft.com/azure/)
- [C# Coding Conventions](https://docs.microsoft.com/dotnet/csharp/fundamentals/coding-style/coding-conventions)
- [Azure Architecture Center](https://docs.microsoft.com/azure/architecture/)

---

## 📝 Histórico de Atualizações

- **2025-11-22**: Adicionada seção sobre regras para criar atividades no GitHub Project Board
- **2025-11-22**: Adicionado processo de commit e push com aprovação obrigatória
- **2025-11-24**: Adicionada regra sobre identificação de data atual e correção de datas incorretas
- **2025-11-24**: Adicionada regra para NUNCA modificar atividades com Status "Done"
- **2025-11-24**: Reorganizado arquivo para melhor legibilidade e adicionada regra obrigatória de sempre incluir datas
- **2025-11-24**: Adicionada regra obrigatória de que TODAS as issues devem ter Label, Sprint, Priority, Status e Data de Criação
- **2025-11-24**: Adicionada regra para economizar arquivos .md - focar apenas no essencial
- **2025-11-24**: Esclarecido que Priority, Status, Labels e Sprint são FIELDS no Project Board (não apenas no body)
- **2025-11-24**: Adicionada regra para identificar Week atual ao criar nova atividade e reorganizar conforme necessário
- **2025-11-24**: Adicionada seção sobre como atualizar fields do Project Board via CLI usando script PowerShell
- **2025-11-24**: Adicionada seção sobre como visualizar issues/atividades quando solicitado pelo usuário
- **2025-11-25**: Adicionado estilo de trabalho progressivo com documentos (máximo 2-3 por atividade)
- **2025-11-28**: Adicionada seção detalhada sobre como configurar fields via CLI automaticamente (método preferido) com IDs constantes e processo genérico reutilizável
- **2025-11-29**: Adicionado estilo de narração preferido pelo usuário (descrições didáticas com "para que quando..." / "so that when...") para facilitar compreensão, especialmente em explicações de testes e mocks

---

## 🔄 Regras de Atualização

- **Este arquivo é vivo**: Pode e deve ser atualizado conforme necessário
- **Adicionar regras conforme surgem**: Quando padrões novos são estabelecidos, documentar aqui
- **Revisar periodicamente**: Manter regras atualizadas e relevantes
