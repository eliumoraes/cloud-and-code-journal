# Script para atualizar campos Priority e Sprint no GitHub Project Board
# Usa GraphQL API do GitHub Projects v2

$projectId = "PVT_kwHOASlIzM4BI0d-"
$priorityFieldId = "PVTSSF_lAHOASlIzM4BI0d-zg5KumI"
$sprintFieldId = "PVTF_lAHOASlIzM4BI0d-zg5KurQ"

# Mapeamento de Priority IDs
$priorityIds = @{
    "Low" = "3ef78ad9"
    "Medium" = "12352b70"
    "High" = "bf4198d7"
}

# Mapeamento de issues por número com Priority e Sprint
$issuesConfig = @{
    # Semana 1
    1 = @{Priority="High"; Sprint="Week 1"}
    2 = @{Priority="Medium"; Sprint="Week 1"}
    4 = @{Priority="Medium"; Sprint="Week 1"}
    5 = @{Priority="High"; Sprint="Week 1"}
    6 = @{Priority="Medium"; Sprint="Week 1"}
    7 = @{Priority="Low"; Sprint="Week 1"}
    8 = @{Priority="High"; Sprint="Week 1"}
    9 = @{Priority="Medium"; Sprint="Week 1"}
    10 = @{Priority="Medium"; Sprint="Week 1"}
    11 = @{Priority="High"; Sprint="Week 1"}
    12 = @{Priority="High"; Sprint="Week 1"}
    
    # Semana 2
    14 = @{Priority="Medium"; Sprint="Week 2"}
    15 = @{Priority="Medium"; Sprint="Week 2"}
    16 = @{Priority="High"; Sprint="Week 2"}
    17 = @{Priority="High"; Sprint="Week 2"}
    18 = @{Priority="High"; Sprint="Week 2"}
    19 = @{Priority="Medium"; Sprint="Week 2"}
    20 = @{Priority="Low"; Sprint="Week 2"}
    21 = @{Priority="Medium"; Sprint="Week 2"}
    
    # Semana 3
    22 = @{Priority="Medium"; Sprint="Week 3"}
    23 = @{Priority="Medium"; Sprint="Week 3"}
    24 = @{Priority="High"; Sprint="Week 3"}
    25 = @{Priority="High"; Sprint="Week 3"}
    26 = @{Priority="Medium"; Sprint="Week 3"}
    27 = @{Priority="Low"; Sprint="Week 3"}
    
    # Semana 4
    28 = @{Priority="Medium"; Sprint="Week 4"}
    29 = @{Priority="Medium"; Sprint="Week 4"}
    30 = @{Priority="High"; Sprint="Week 4"}
    31 = @{Priority="High"; Sprint="Week 4"}
    32 = @{Priority="High"; Sprint="Week 4"}
    33 = @{Priority="Low"; Sprint="Week 4"}
}

# Mapeamento de issue numbers para project item IDs
$issueItemIds = @{
    1 = "PVTI_lAHOASlIzM4BI0d-zghl14w"
    2 = "PVTI_lAHOASlIzM4BI0d-zghl140"
    4 = "PVTI_lAHOASlIzM4BI0d-zghl148"
    5 = "PVTI_lAHOASlIzM4BI0d-zghl15E"
    6 = "PVTI_lAHOASlIzM4BI0d-zghl15I"
    7 = "PVTI_lAHOASlIzM4BI0d-zghl15M"
    8 = "PVTI_lAHOASlIzM4BI0d-zghmR2w"
    9 = "PVTI_lAHOASlIzM4BI0d-zghmR3E"
    10 = "PVTI_lAHOASlIzM4BI0d-zghmR3I"
    11 = "PVTI_lAHOASlIzM4BI0d-zghmR3U"
    12 = "PVTI_lAHOASlIzM4BI0d-zghmR3Y"
    14 = "PVTI_lAHOASlIzM4BI0d-zghmR-Q"
    15 = "PVTI_lAHOASlIzM4BI0d-zghmR-g"
    16 = "PVTI_lAHOASlIzM4BI0d-zghmR-o"
    17 = "PVTI_lAHOASlIzM4BI0d-zghmR-s"
    18 = "PVTI_lAHOASlIzM4BI0d-zghmR-8"
    19 = "PVTI_lAHOASlIzM4BI0d-zghmR_M"
    20 = "PVTI_lAHOASlIzM4BI0d-zghmR_Y"
    21 = "PVTI_lAHOASlIzM4BI0d-zghmR_o"
    22 = "PVTI_lAHOASlIzM4BI0d-zghmSAI"
    23 = "PVTI_lAHOASlIzM4BI0d-zghmSAQ"
    24 = "PVTI_lAHOASlIzM4BI0d-zghmSAY"
    25 = "PVTI_lAHOASlIzM4BI0d-zghmSAg"
    26 = "PVTI_lAHOASlIzM4BI0d-zghmSAk"
    27 = "PVTI_lAHOASlIzM4BI0d-zghmSA4"
    28 = "PVTI_lAHOASlIzM4BI0d-zghmSBc"
    29 = "PVTI_lAHOASlIzM4BI0d-zghmSBk"
    30 = "PVTI_lAHOASlIzM4BI0d-zghmSB0"
    31 = "PVTI_lAHOASlIzM4BI0d-zghmSB8"
    32 = "PVTI_lAHOASlIzM4BI0d-zghmSCE"
    33 = "PVTI_lAHOASlIzM4BI0d-zghmSCU"
}

Write-Host "Atualizando campos Priority e Sprint para $($issuesConfig.Count) issues..." -ForegroundColor Cyan
Write-Host ""

$successCount = 0
$errorCount = 0

foreach ($issueNumber in $issuesConfig.Keys | Sort-Object) {
    $config = $issuesConfig[$issueNumber]
    $itemId = $issueItemIds[$issueNumber]
    $priorityValue = $config.Priority
    $sprintValue = $config.Sprint
    $priorityOptionId = $priorityIds[$priorityValue]
    
    if (-not $itemId) {
        Write-Host "⚠️  Issue #$issueNumber não encontrada no projeto" -ForegroundColor Yellow
        $errorCount++
        continue
    }
    
    Write-Host "Atualizando Issue #$issueNumber - Priority: $priorityValue, Sprint: $sprintValue" -ForegroundColor Gray
    
    # Atualizar Priority (Single Select)
    $priorityMutation = @"
mutation {
    updateProjectV2ItemFieldValue(
        input: {
            projectId: "$projectId"
            itemId: "$itemId"
            fieldId: "$priorityFieldId"
            value: {
                singleSelectOptionId: "$priorityOptionId"
            }
        }
    ) {
        projectV2Item {
            id
        }
    }
}
"@
    
    try {
        $result = gh api graphql -f query=$priorityMutation 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-Host "  ✓ Priority atualizado" -ForegroundColor Green
        } else {
            Write-Host "  ✗ Erro ao atualizar Priority: $result" -ForegroundColor Red
            $errorCount++
            continue
        }
    } catch {
        Write-Host "  ✗ Erro ao atualizar Priority: $_" -ForegroundColor Red
        $errorCount++
        continue
    }
    
    # Atualizar Sprint (Text)
    $sprintMutation = @"
mutation {
    updateProjectV2ItemFieldValue(
        input: {
            projectId: "$projectId"
            itemId: "$itemId"
            fieldId: "$sprintFieldId"
            value: {
                text: "$sprintValue"
            }
        }
    ) {
        projectV2Item {
            id
        }
    }
}
"@
    
    try {
        $result = gh api graphql -f query=$sprintMutation 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-Host "  ✓ Sprint atualizado" -ForegroundColor Green
            $successCount++
        } else {
            Write-Host "  ✗ Erro ao atualizar Sprint: $result" -ForegroundColor Red
            $errorCount++
        }
    } catch {
        Write-Host "  ✗ Erro ao atualizar Sprint: $_" -ForegroundColor Red
        $errorCount++
    }
    
    Write-Host ""
    
    # Pequeno delay para não sobrecarregar a API
    Start-Sleep -Milliseconds 200
}

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Resumo:" -ForegroundColor Cyan
Write-Host "  ✓ Sucesso: $successCount issues" -ForegroundColor Green
Write-Host "  ✗ Erros: $errorCount issues" -ForegroundColor $(if ($errorCount -gt 0) { "Red" } else { "Green" })
Write-Host "========================================" -ForegroundColor Cyan

