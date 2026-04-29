# Ensure SQL Server Agent starts automatically

$serviceName = "SQLSERVERAGENT"

# Set startup type to Automatic
Set-Service -Name $serviceName -StartupType Automatic

# Check current status
$service = Get-Service -Name $serviceName

if ($service.Status -ne "Running") {
    Start-Service -Name $serviceName
    Write-Output "SQL Server Agent started successfully."
} else {
    Write-Output "SQL Server Agent is already running."
}

# Validate final state
Get-Service -Name $serviceName
