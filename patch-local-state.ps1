# Windows PowerShell Script to patch Chrome's Local State file
# ⚠️ AI-Generated Script. Run at your own risk. Author has not executed this code.

$chromePath = "$env:LOCALAPPDATA\Google\Chrome\User Data\Local State"

if (-not (Test-Path $chromePath)) {
    Write-Error "Chrome Local State file not found at: $chromePath"
    exit
}

# Ensure Chrome is closed
Write-Host "Closing Google Chrome instances..." -ForegroundColor Yellow
Stop-Process -Name "chrome" -ErrorAction SilentlyContinue
Start-Sleep -Seconds 2

# Backup original file
Copy-Item $chromePath "$chromePath.bak" -Force
Write-Host "Backup created at: $chromePath.bak" -ForegroundColor Green

# Replace country codes
# Targets fields like "variations_country", "variations_permanent_consistency_country", etc.
Write-Host "Patching geographical variations from 'IL' to 'US'..." -ForegroundColor Cyan
$content = Get-Content -Raw -Path $chromePath -Encoding UTF8

# Using regex to handle potential spacing and match all variation country keys
$pattern = '"(variations_[^"]*country[^"]*)"\s*:\s*"IL"'
# Using single quotes for the replacement string to prevent incorrect variable interpolation in PowerShell
$replacement = '"$1":"US"'
$patchedContent = [regex]::Replace($content, $pattern, $replacement)

# Save file back using UTF8 without BOM for cross-platform compatibility
$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($chromePath, $patchedContent, $utf8NoBom)

Write-Host "Success! Restart Google Chrome to see changes." -ForegroundColor Green
