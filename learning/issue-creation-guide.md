# Guia de Criação de Issues

Este documento serve como referência para garantir que todas as issues criadas tenham os campos obrigatórios preenchidos corretamente.

## Campos Obrigatórios

Todas as issues devem ter no final do body:

```markdown
---

**Status**: To do
**Priority**: [High/Medium/Low]
**Sprint**: [Week 1/Week 2/Week 3/Week 4]
```

## Prioridades (Priority)

### High
- Aprendizados críticos e fundamentais
- Projetos principais e POCs essenciais
- Auto-avaliação técnica
- Conceitos que são pré-requisitos para outros

### Medium
- Estudos complementares
- Desafios intermediários
- POCs secundárias
- Revisões de perguntas

### Low
- Journal entries semanais
- Tarefas opcionais
- Melhorias e refinamentos

## Sprint (Week)

### Week 1: Diagnóstico e Início Facilitado
- Auto-avaliação técnica
- Coding challenges básicos (Exercism Easy, Codewars 8 kyu)
- Estudos teóricos fundamentais
- POC simples (Azure App Service)

### Week 2: Fundamentos Iniciais
- Coding challenges (Exercism Easy, Codewars 7-8 kyu)
- Estudos teóricos (.NET Core vs Framework, Memory Management)
- Continuar POCs da semana 1
- Revisão de perguntas

### Week 3: Aceleração Progressiva
- Coding challenges (mix Easy/Medium)
- Estudos teóricos (Design Patterns, SOLID)
- POC Azure (Functions ou Service Bus)
- Revisão de perguntas acumuladas

### Week 4: Consolidação
- Coding challenges (aumentar dificuldade)
- Estudos teóricos (Performance, Advanced C#)
- Finalizar POCs iniciadas
- Revisão completa de perguntas

## Formato Padrão no Final do Body

```markdown
---

**Status**: To do
**Priority**: [High/Medium/Low]
**Sprint**: Week [1/2/3/4]
```

## Exemplo Completo

```markdown
## 📚 Objetivo de Aprendizado

[Descrição do objetivo]

## 🎯 Tópicos a Cobrir

- [ ] Tópico 1
- [ ] Tópico 2

## 📖 Recursos Disponíveis

- [Recurso 1](url)

## 💻 Prática Proposta

- [ ] Prática 1

## ✅ Critérios de Conclusão

- [ ] Critério 1

## 📝 Notas

[Notas adicionais]

---

**Status**: To do
**Priority**: High
**Sprint**: Week 1
```

## Checklist ao Criar Issue

- [ ] Título descritivo **SEM prefixos** (não usar `[LEARNING]`, `[CHALLENGE]`, etc.)
- [ ] Label correto aplicado (learning/challenge/project/journal)
- [ ] Assignee configurado (@me)
- [ ] Body completo com todas as seções
- [ ] **Priority definida** (High/Medium/Low)
- [ ] **Sprint definida** (Week 1/2/3/4)
- [ ] Status definido (To do)

## Nomenclatura de Títulos

**IMPORTANTE**: Não inclua prefixos no título da issue. O label já identifica o tipo visualmente no board.

### Exemplos Corretos ✅
- "Auto-avaliação Técnica .NET e Azure"
- "Exercism - TwoFer"
- "POC: Azure App Service + API REST"
- "Baseline" (para journal - semana no Sprint)
- "18/11/2025 a 24/11/2025" (para journal com datas)

### Exemplos Incorretos ❌
- "[LEARNING] Auto-avaliação Técnica .NET e Azure"
- "[CHALLENGE] Exercism - TwoFer"
- "[PROJECT] POC: Azure App Service + API REST"
- "[JOURNAL] Semana 1 - Baseline"
- "Semana 1 - Baseline" (use apenas "Baseline", configure Sprint = Week 1)
- "Week 2 - Fundamentos" (use apenas "Fundamentos", configure Sprint = Week 2)

## Notas Importantes

1. **Sempre incluir Priority e Sprint no body** - Esses campos são essenciais para organização no Project Board
2. **Usar formato consistente** - Facilita parsing e organização
3. **Revisar antes de criar** - Garantir que todos os campos estão preenchidos
4. **Manter padrão** - Todas as issues devem seguir o mesmo formato

---

**Última atualização**: 2025-11-24

