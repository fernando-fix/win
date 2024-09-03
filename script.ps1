# Define a senha de acesso (esta senha está codificada no script; ajuste conforme necessário)
$senhaCorreta = ConvertTo-SecureString "Connectta**2024" -AsPlainText -Force

# Função para verificar a senha
function Verificar-Senha {
    $senhaInserida = Read-Host "Digite a senha de acesso" -AsSecureString

    # Converte as senhas para strings para comparação
    $senhaCorretaString = [System.Net.NetworkCredential]::new($senhaCorreta).Password
    $senhaInseridaString = [System.Net.NetworkCredential]::new($senhaInserida).Password

    if ($senhaInseridaString -eq $senhaCorretaString) {
        return $true
    } else {
        Write-Host "Senha incorreta. Acesso negado." -ForegroundColor Red
        return $false
    }
}

# Define a função para limpar o prefetch
function Limpar-Prefetch {
    Write-Host "Limpando prefetch..."
    Remove-Item -Path "$env:SystemRoot\Prefetch\*" -Force
    Write-Host "Prefetch limpo com sucesso!"
}

# Define a função para limpar a pasta %TEMP%
function Limpar-Temp {
    Write-Host "Limpando a pasta TEMP..."
    Remove-Item -Path "$env:TEMP\*" -Force
    Write-Host "Pasta TEMP limpa com sucesso!"
}

# Define a função para limpeza de disco
function Limpeza-Disco {
    Write-Host "Iniciando limpeza de disco..."
    Start-Process -FilePath "cleanmgr.exe" -ArgumentList "/sagerun:1" -Wait
    Write-Host "Limpeza de disco concluída!"
}

# Define a função para executar sfc /scannow
function Executar-SFC {
    Write-Host "Iniciando verificação de integridade do sistema..."
    Start-Process -FilePath "sfc.exe" -ArgumentList "/scannow" -Wait
    Write-Host "Verificação SFC concluída!"
}

# Define a função para executar chkdsk
function Executar-CHKDSK {
    Write-Host "Iniciando verificação de disco (chkdsk)..."
    Start-Process -FilePath "chkdsk.exe" -ArgumentList "/f /r" -Wait
    Write-Host "Verificação de disco concluída! Pode ser necessário reiniciar o sistema para concluir a verificação."
}

# Exibe o menu e obtém a escolha do usuário
function Mostrar-Menu {
    Clear-Host
    Write-Host "Painel de Manutenção do Sistema" -ForegroundColor Cyan
    Write-Host "1. Limpar Prefetch"
    Write-Host "2. Limpar Arquivos Temporários"
    Write-Host "3. Limpeza de Disco"
    Write-Host "4. Executar Verificação de Integridade do Sistema"    
    Write-Host "5. Executar Verificação de Disco (chkdsk)"
    Write-Host "0. Sair"
    $escolha = Read-Host "Escolha uma opção"

    switch ($escolha) {
        '1' { Limpar-Prefetch }
        '2' { Limpar-Temp }
        '3' { Limpeza-Disco }
        '4' { Executar-SFC }
        '5' { Executar-CHKDSK }
        '0' { exit }
        default { Write-Host "Opção inválida. Tente novamente." }
    }
}

# Executa o menu em loop até o usuário escolher sair
do {
    if (Verificar-Senha) {
        do {
            Mostrar-Menu
        } while ($true)
    }
} while ($true)
