# Script de Manutenção do Sistema Operacional Windows

# Função para verificar atualizações do Windows
function Check-WindowsUpdates {
    Write-Output "Verificando atualizações do Windows..."
    Install-WindowsUpdate -AcceptAll -AutoReboot
    Write-Output "Verificação de atualizações concluída."
}

# Função para limpar arquivos temporários
function Clean-TempFiles {
    Write-Output "Limpando arquivos temporários..."
    $tempPaths = @(
        "$env:TEMP",
        "$env:SystemRoot\Temp",
        [System.IO.Path]::Combine($env:SystemDrive, "Windows\Prefetch")
    )
    foreach ($path in $tempPaths) {
        if (Test-Path $path) {
            Remove-Item -Path $path\* -Recurse -Force -ErrorAction SilentlyContinue
            Write-Output "Limpeza de $path concluída."
        }
    }
}

# Função para desfragmentar o disco
function Defragment-Disks {
    Write-Output "Desfragmentando discos..."
    defrag C: /O
    Write-Output "Desfragmentação concluída."
}

# Função para verificar e corrigir arquivos do sistema
function Check-SystemFiles {
    Write-Output "Verificando arquivos do sistema..."
    sfc /scannow
    Write-Output "Verificação de arquivos do sistema concluída."
}

# Executar as funções de manutenção
Check-WindowsUpdates
Clean-TempFiles
Defragment-Disks
Check-SystemFiles

Write-Output "Manutenção do sistema operacional concluída."
