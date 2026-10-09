$ErrorActionPreference = 'Stop'

$projectRoot = Split-Path -Parent $PSScriptRoot
Push-Location $projectRoot
try {
  & $PSScriptRoot\check-citations.ps1
  if (-not $?) { exit 1 }

  $buildLog = Join-Path $projectRoot 'build/build.log'
  Set-Content -LiteralPath $buildLog -Value "Thesis build started $(Get-Date -Format o)"
  $latexArgs = @('-interaction=nonstopmode', '-halt-on-error', '-output-directory=build', 'usmthesis.tex')
  & pdflatex @latexArgs *>> $buildLog
  if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

  Push-Location (Join-Path $projectRoot 'build')
  try {
    $env:BIBINPUTS = "$projectRoot;"
    & bibtex usmthesis *>> $buildLog
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
    & bibtex own *>> $buildLog
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
  } finally {
    Pop-Location
  }

  & pdflatex @latexArgs *>> $buildLog
  if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
  & pdflatex @latexArgs *>> $buildLog
  if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

  $importantDiagnostics = Select-String -LiteralPath $buildLog -Pattern 'undefined|Undefined|There were undefined|No file|Error|Fatal|Emergency stop|I couldn''t find|Missing bibliography'
  if ($importantDiagnostics) {
    Write-Host 'Important diagnostics:'
    $importantDiagnostics | ForEach-Object { Write-Host $_.Line }
  } else {
    Write-Host 'Build completed. No blocking diagnostics found.'
  }
  Write-Host "Full build output: $buildLog"
} finally {
  Pop-Location
}