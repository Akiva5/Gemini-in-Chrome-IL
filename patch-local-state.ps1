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
Write-Host "Patching geographical variations from 'IL' to 'US'..." -ForegroundColor Cyan
$content = Get-Content -Raw -Path $chromePath -Encoding UTF8
$patchedContent = $content -replace '("variations(?:_permanent_consistency)?_country"\s*:\s*)"IL"', '${1}"US"'

# Save file back
Set-Content -Path $chromePath -Value $patchedContent -Encoding UTF8
Write-Host "Success! Restart Google Chrome to see changes." -ForegroundColor Green

# Remove backup file after use to prevent sensitive data accumulation
Remove-Item "$chromePath.bak" -Force -ErrorAction SilentlyContinue
