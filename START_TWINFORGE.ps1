$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$backend = Join-Path $root 'backend'
$frontend = Join-Path $root 'frontend'

Write-Host 'TwinForge launcher' -ForegroundColor Cyan
Write-Host 'Make sure PostgreSQL is running and database twinforge exists.' -ForegroundColor Yellow

Start-Process powershell -ArgumentList '-NoExit','-Command', "Set-Location '$backend'; .\.venv\Scripts\Activate.ps1; uvicorn app.main:app --reload"
Start-Sleep -Seconds 2
Start-Process powershell -ArgumentList '-NoExit','-Command', "Set-Location '$backend'; .\.venv\Scripts\Activate.ps1; `$env:PYTHONPATH='.'; python -m scripts.seed; python -m scripts.run_simulator"
Start-Process powershell -ArgumentList '-NoExit','-Command', "Set-Location '$frontend'; npm run dev"

Start-Sleep -Seconds 3
Start-Process 'http://127.0.0.1:8000/docs'
Start-Process 'http://localhost:5173'
