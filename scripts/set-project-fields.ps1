# Script para configurar campos Priority e Sprint no GitHub Project Board
# Requer: Token do GitHub com permissões read:project e write:project

param(
    [string]$GitHubToken = "",
    [string]$ProjectNumber = 1
)

# Verificar se o token foi fornecido
if ([string]::IsNullOrEmpty($GitHubToken)) {
    Write-Host "Erro: Token do GitHub não fornecido." -ForegroundColor Red
    Write-Host "Use: .\set-project-fields.ps1 -GitHubToken 'seu_token' -ProjectNumber 1" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Para obter um token com permissões de projeto:" -ForegroundColor Yellow
    Write-Host "1. Acesse: https://github.com/settings/tokens" -ForegroundColor Yellow
    Write-Host "2. Crie um novo token com escopos: read:project, write:project" -ForegroundColor Yellow
    exit 1
}

# Configurar token
$env:GH_TOKEN = $GitHubToken

# Mapeamento de issues por semana e priority
$issuesConfig = @(
    # Semana 1
    @{Number=1; Priority="High"; Sprint="Week 1"},
    @{Number=2; Priority="Medium"; Sprint="Week 1"},
    @{Number=4; Priority="Medium"; Sprint="Week 1"},
    @{Number=5; Priority="High"; Sprint="Week 1"},
    @{Number=6; Priority="Medium"; Sprint="Week 1"},
    @{Number=7; Priority="Low"; Sprint="Week 1"},
    @{Number=8; Priority="High"; Sprint="Week 1"},
    @{Number=9; Priority="Medium"; Sprint="Week 1"},
    @{Number=10; Priority="Medium"; Sprint="Week 1"},
    @{Number=11; Priority="High"; Sprint="Week 1"},
    @{Number=12; Priority="High"; Sprint="Week 1"},
    
    # Semana 2
    @{Number=14; Priority="Medium"; Sprint="Week 2"},
    @{Number=15; Priority="Medium"; Sprint="Week 2"},
    @{Number=16; Priority="High"; Sprint="Week 2"},
    @{Number=17; Priority="High"; Sprint="Week 2"},
    @{Number=18; Priority="High"; Sprint="Week 2"},
    @{Number=19; Priority="Medium"; Sprint="Week 2"},
    @{Number=20; Priority="Low"; Sprint="Week 2"},
    @{Number=21; Priority="Medium"; Sprint="Week 2"},
    
    # Semana 3
    @{Number=22; Priority="Medium"; Sprint="Week 3"},
    @{Number=23; Priority="Medium"; Sprint="Week 3"},
    @{Number=24; Priority="High"; Sprint="Week 3"},
    @{Number=25; Priority="High"; Sprint="Week 3"},
    @{Number=26; Priority="Medium"; Sprint="Week 3"},
    @{Number=27; Priority="Low"; Sprint="Week 3"},
    
    # Semana 4
    @{Number=28; Priority="Medium"; Sprint="Week 4"},
    @{Number=29; Priority="Medium"; Sprint="Week 4"},
    @{Number=30; Priority="High"; Sprint="Week 4"},
    @{Number=31; Priority="High"; Sprint="Week 4"},
    @{Number=32; Priority="High"; Sprint="Week 4"},
    @{Number=33; Priority="Low"; Sprint="Week 4"}
)

Write-Host "Configurando campos Priority e Sprint para $($issuesConfig.Count) issues..." -ForegroundColor Cyan
Write-Host ""

# Nota: Este script requer acesso à API do GitHub Projects v2
# A implementação completa requer:
# 1. Obter o ID do projeto
# 2. Obter os IDs dos campos customizados (Priority e Sprint)
# 3. Obter os IDs das issues no contexto do projeto
# 4. Atualizar os valores dos campos

Write-Host "Este script requer:" -ForegroundColor Yellow
Write-Host "1. Token do GitHub com permissões read:project e write:project" -ForegroundColor Yellow
Write-Host "2. ID do Project Board" -ForegroundColor Yellow
Write-Host "3. IDs dos campos customizados Priority e Sprint" -ForegroundColor Yellow
Write-Host ""
Write-Host "Para obter essas informações, você pode usar:" -ForegroundColor Cyan
Write-Host "gh api graphql -f query='{ viewer { projectsV2(first: 10) { nodes { id title number } } } }'" -ForegroundColor Gray
Write-Host ""
Write-Host "Por enquanto, configure manualmente no Project Board usando o guia:" -ForegroundColor Green
Write-Host "learning/project-board-fields-setup.md" -ForegroundColor Green



