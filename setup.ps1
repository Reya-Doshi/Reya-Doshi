<#
.SYNOPSIS
    Generate every local asset for Reya Doshi's GitHub profile README.

.EXAMPLE
    .\setup.ps1 -Image .\me.png -Cols 100 -Equalize -Detail 0.5 -Color
#>
[CmdletBinding()]
param(
    [string]$Username = "Reya-Doshi",
    [string]$Name = "Reya Doshi",
    [string]$Image = "me.png",
    [ValidateSet('dots', 'binary', 'ascii', 'braille')]
    [string]$Mode = 'dots',
    [int]$Cols = 100,
    [switch]$Circle,
    [switch]$Color = $true,
    [switch]$Equalize = $true,
    [float]$Detail = 0.5,
    [switch]$Reveal = $true
)

$ErrorActionPreference = 'Stop'
$root = $PSScriptRoot

Write-Host "`n[1/3] Drawing the skill radar" -ForegroundColor Magenta
python (Join-Path $root 'scripts\radar.py') --data (Join-Path $root 'assets\skills.json') -o (Join-Path $root 'assets\radar')

Write-Host "      Drawing the language radar" -ForegroundColor Magenta
try {
    python (Join-Path $root 'scripts\radar.py') --github $Username -o (Join-Path $root 'assets\radar-langs') --values --curve 0.4
} catch {
    Write-Warning "language radar fallback used: $_"
}

Write-Host "`n[2/3] Drawing stat and repo cards" -ForegroundColor Magenta
python (Join-Path $root 'scripts\cards.py') --user $Username --projects (Join-Path $root 'assets\projects.json') --out (Join-Path $root 'assets')

if (Test-Path (Join-Path $root $Image)) {
    Write-Host "`n[3/3] Dot-matrixing $Image" -ForegroundColor Magenta
    $dotArgs = @(
        (Join-Path $root 'scripts\dotify.py'), (Join-Path $root $Image),
        '-o', (Join-Path $root 'assets\portrait'),
        '--cols', $Cols, '--detail', $Detail
    )
    if ($Equalize) { $dotArgs += '--equalize' }
    if ($Color)    { $dotArgs += '--color' }
    if ($Reveal)   { $dotArgs += '--reveal' }
    python @dotArgs
} else {
    Write-Host "`n[3/3] $Image not found, skipping portrait dotify" -ForegroundColor DarkGray
}

Write-Host "`nDone! Open preview.html in your browser to check your live profile preview.`n" -ForegroundColor Green
