# Como Configurar Campos Customizados no GitHub Project Board

## Problema

Os campos customizados **Priority** e **Sprint** não são populados automaticamente pelo conteúdo do body da issue. Eles precisam ser configurados manualmente no Project Board ou via API do GitHub Projects.

## Solução Manual (Recomendada)

### Passo a Passo

1. **Acesse o Project Board**
   - Vá para o repositório no GitHub
   - Clique em **Projects** no menu superior
   - Abra o board "Cloud and Code Journal"

2. **Para cada issue no board:**
   - Clique no card da issue
   - Ou clique nos três pontinhos (⋯) no card
   - Selecione **Edit fields** ou clique diretamente nos campos

3. **Configure os campos:**
   - **Priority**: Selecione High, Medium ou Low (conforme definido no body da issue)
   - **Sprint**: Digite Week 1, Week 2, Week 3 ou Week 4 (conforme definido no body da issue)
   - **Status**: Deixe como "To do" (padrão inicial)

4. **Salve as alterações**

## Mapeamento de Issues por Semana

### Semana 1
- Issues: #1, #2, #4, #5, #6, #7, #8, #9, #10, #11, #12
- Priority: Conforme definido no body de cada issue
- Sprint: Week 1

### Semana 2
- Issues: #14, #15, #16, #17, #18, #19, #20, #21
- Priority: Conforme definido no body de cada issue
- Sprint: Week 2

### Semana 3
- Issues: #22, #23, #24, #25, #26, #27
- Priority: Conforme definido no body de cada issue
- Sprint: Week 3

### Semana 4
- Issues: #28, #29, #30, #31, #32, #33
- Priority: Conforme definido no body de cada issue
- Sprint: Week 4

## Script de Referência (Para Automação Futura)

Se quiser automatizar no futuro, você pode usar a API do GitHub Projects:

```bash
# Exemplo de como configurar campos via API (requer token com permissões)
# Nota: Isso requer acesso à API do GitHub Projects v2
```

## Verificação

Para verificar se todas as issues têm Priority e Sprint no body:

```bash
gh issue list --state open --json number,title,body | \
  jq '.[] | select(.body | test("\\*\\*Priority\\*\\*:") | not) | .number'
```

## Notas Importantes

1. **Todas as issues já têm Priority e Sprint no body** - isso serve como documentação
2. **Os campos customizados no board precisam ser configurados manualmente** - não há forma automática via GitHub CLI atualmente
3. **Use o body da issue como referência** - o valor está sempre documentado lá
4. **Configure em lote** - você pode selecionar múltiplas issues no board e configurar campos em massa

---

**Última atualização**: 2025-11-24



