# Checklist de Revisão de Issues Existentes

Este documento serve como guia para revisar e organizar as issues existentes no GitHub antes de criar novas issues.

## Objetivo

Garantir que todas as issues existentes estejam:
- Com labels corretos
- Com prioridades adequadas
- Organizadas por semanas (Week 1, Week 2, etc.)
- Com campos customizados preenchidos (Status, Priority, Sprint, Assignee)
- Aparecendo nas views corretas do board

## Checklist de Revisão

### Para Cada Issue Existente

- [ ] **Label está correto?**
  - `learning` - Para estudos e aprendizado
  - `challenge` - Para exercícios (Exercism, Codewars, LeetCode)
  - `project` - Para POCs e projetos reais
  - `journal` - Para entradas semanais no journal
  - `feature` - Para features e funcionalidades (se aplicável)

- [ ] **Priority está definida?**
  - `High` - Aprendizados críticos, projetos principais, deadlines importantes
  - `Medium` - Estudos complementares, desafios intermediários
  - `Low` - Tarefas opcionais, melhorias, journal entries

- [ ] **Sprint está definida?**
  - `Week 1` - Semana 1: Diagnóstico e Início Facilitado
  - `Week 2` - Semana 2: Fundamentos Iniciais
  - `Week 3` - Semana 3: Aceleração Progressiva
  - `Week 4` - Semana 4: Consolidação
  - Ou deixar vazio se ainda não foi planejada

- [ ] **Status está correto?**
  - `To do` - Tarefa planejada, mas ainda não iniciada
  - `In progress` - Tarefa em andamento (aparece em "My Work")
  - `Blocked` - Tarefa bloqueada por alguma dependência
  - `Done` - Tarefa concluída (aparece em "Done")

- [ ] **Assignee está configurado?**
  - Deve estar atribuído para você (@me)
  - Isso garante que apareça em "My Work" quando estiver em progresso

- [ ] **Issue aparece na view correta?**
  - **My Work**: Se `assignee:@me` E `status:In progress`
  - **Backlog**: Se `status:To do`
  - **Learning**: Se `label:learning`
  - **Done**: Se `status:Done`

## Mapeamento de Issues por Tipo

### Issues de Learning
Devem ter:
- Label: `learning`
- Priority: `High` (conceitos críticos) ou `Medium` (complementares)
- Sprint: Definir conforme semana planejada
- Status: `To do` (se ainda não iniciada)

### Issues de Challenge
Devem ter:
- Label: `challenge`
- Priority: `Medium` (maioria) ou `High` (se for baseline inicial)
- Sprint: Definir conforme semana planejada
- Status: `To do` (se ainda não iniciada)

### Issues de Project
Devem ter:
- Label: `project`
- Priority: `High` (POCs principais) ou `Medium` (POCs secundárias)
- Sprint: Definir conforme semana planejada
- Status: `To do` (se ainda não iniciada)

### Issues de Journal
Devem ter:
- Label: `journal`
- Priority: `Low`
- Sprint: Definir conforme semana correspondente
- Status: `To do` (se ainda não iniciada)

## Organização por Semanas

### Semana 1: Diagnóstico e Início Facilitado
Issues esperadas:
- 1 Auto-avaliação técnica (learning, High)
- 2-3 Coding challenges básicos (challenge, Medium)
- 1 Estudo teórico fundamental (learning, High)
- 1 POC simples (project, High)
- 1 Journal entry (journal, Low)

### Semana 2: Fundamentos Iniciais
Issues esperadas:
- 3-4 Coding challenges (challenge, Medium)
- 1 Estudo teórico (learning, High)
- 1 POC ou continuação (project, High)
- 1 Revisão de perguntas (learning, Medium)
- 1 Journal entry (journal, Low)

### Semana 3: Aceleração Progressiva
Issues esperadas:
- 4-5 Coding challenges (challenge, Medium)
- 1 Estudo teórico (learning, High)
- 1 POC Azure (project, High)
- 1 Revisão de perguntas (learning, Medium)
- 1 Journal entry (journal, Low)

### Semana 4: Consolidação
Issues esperadas:
- 4-5 Coding challenges (challenge, Medium)
- 1 Estudo teórico (learning, High)
- Finalizar POCs (project, High)
- 1 Revisão completa (learning, High)
- 1 Journal entry (journal, Low)

## Ações a Tomar

### Se Issue Não Tem Label
1. Identificar o tipo da issue (learning, challenge, project, journal)
2. Adicionar label apropriado
3. Verificar se aparece na view correta

### Se Issue Não Tem Priority
1. Avaliar importância conforme plano
2. Definir priority (High/Medium/Low)
3. Atualizar no board

### Se Issue Não Tem Sprint
1. Avaliar conteúdo da issue
2. Mapear para semana apropriada (1-4)
3. Definir Sprint no board

### Se Issue Não Tem Assignee
1. Atribuir para você (@me)
2. Verificar se aparece em "My Work" quando em progresso

### Se Issue Está Desorganizada
1. Revisar conteúdo
2. Reclassificar conforme necessário
3. Ajustar labels, priority e sprint
4. Mover para semana apropriada

## Notas Importantes

- **Não deletar issues existentes**: Apenas reorganizar e ajustar
- **Manter histórico**: Se uma issue já foi trabalhada, manter status "Done"
- **Priorizar issues da Semana 1**: Garantir que estão bem organizadas para começar
- **Usar este checklist**: Antes de criar novas issues, garantir que as existentes estão organizadas

## Próximos Passos Após Revisão

1. ✅ Completar revisão de todas as issues existentes
2. ⏳ Documentar issues que precisam ser ajustadas
3. ⏳ Ajustar issues conforme checklist
4. ⏳ Verificar se todas aparecem nas views corretas
5. ⏳ Aguardar comando "build" para criar novas issues das semanas 1-4

---

**Última atualização**: 2025-11-24  
**Status**: Em uso para revisão inicial



