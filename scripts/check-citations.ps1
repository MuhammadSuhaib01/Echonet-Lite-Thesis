$ErrorActionPreference = 'Stop'

$projectRoot = Split-Path -Parent $PSScriptRoot
$bibFile = Join-Path $projectRoot 'mybib.bib'

function Get-ActiveTexFiles {
  $pendingFiles = [System.Collections.Generic.Queue[string]]::new()
  $visitedFiles = [System.Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
  $pendingFiles.Enqueue((Join-Path $projectRoot 'usmthesis.tex'))

  while ($pendingFiles.Count -gt 0) {
    $filePath = $pendingFiles.Dequeue()
    $resolvedPath = [IO.Path]::GetFullPath($filePath)
    if (-not $visitedFiles.Add($resolvedPath)) { continue }

    $resolvedPath
    $content = (Get-Content -LiteralPath $resolvedPath) -replace '%.*$', '' | Out-String
    foreach ($match in [regex]::Matches($content, '\\(?:include|input)\{([^}]+)\}')) {
      $includePath = $match.Groups[1].Value
      if ([IO.Path]::GetExtension($includePath) -eq '') { $includePath += '.tex' }
      $pendingFiles.Enqueue((Join-Path (Split-Path -Parent $resolvedPath) $includePath))
    }
  }
}

$texFiles = Get-ActiveTexFiles | ForEach-Object { Get-Item -LiteralPath $_ }

$citationKeys = foreach ($file in $texFiles) {
  $content = (Get-Content -LiteralPath $file.FullName) -replace '%.*$', '' | Out-String
  foreach ($match in [regex]::Matches($content, '\\cite[a-zA-Z*]*(?:\[[^\]]*\]){0,2}\s*\{([^}]*)\}')) {
    $match.Groups[1].Value -split ',' | ForEach-Object { $_.Trim() } | Where-Object { $_ }
  }
}

$bibliographyKeys = [regex]::Matches(
  (Get-Content -Raw -LiteralPath $bibFile),
  '(?m)^\s*@\w+\s*\{\s*([^,\s]+)'
) | ForEach-Object { $_.Groups[1].Value }

$missingKeys = $citationKeys |
  Sort-Object -Unique |
  Where-Object { $_ -notin $bibliographyKeys }

if ($missingKeys) {
  Write-Error ("Missing bibliography keys in {0}:`n - {1}" -f $bibFile, ($missingKeys -join "`n - "))
}

Write-Host ("Citation check passed: {0} unique citation keys found in {1}." -f (($citationKeys | Sort-Object -Unique).Count, $bibFile))