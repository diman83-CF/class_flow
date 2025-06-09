# GitHub Setup Script for Flutter Training Management Project
# Replace YOUR_USERNAME with your actual GitHub username

Write-Host "GitHub Setup Script for Flutter Training Management Project" -ForegroundColor Green
Write-Host "=========================================================" -ForegroundColor Green

# Get GitHub username from user
$username = Read-Host "diman83-CF"

if ([string]::IsNullOrWhiteSpace($username)) {
    Write-Host "Username cannot be empty. Exiting..." -ForegroundColor Red
    exit 1
}

Write-Host "Setting up GitHub repository for user: $username" -ForegroundColor Yellow

# Add remote origin
Write-Host "Adding remote origin..." -ForegroundColor Cyan
    git remote add origin "https://github.com/$username/class_flow.git"

# Rename branch to main (GitHub standard)
Write-Host "Renaming branch to main..." -ForegroundColor Cyan
git branch -M main

# Push to GitHub
Write-Host "Pushing to GitHub..." -ForegroundColor Cyan
git push -u origin main

Write-Host "Setup complete!" -ForegroundColor Green
Write-Host "Your repository is now available at: https://github.com/$username/class_flow" -ForegroundColor Green 