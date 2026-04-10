param(
    [Parameter(Mandatory = $true)]
    [string]$Url,

    [int]$Requests = 20
)

for ($i = 1; $i -le $Requests; $i++) {
    try {
        $response = Invoke-WebRequest -Uri $Url -UseBasicParsing
        Write-Host "Request $i : Status $($response.StatusCode)"
    }
    catch {
        Write-Host "Request $i : Failed - $($_.Exception.Message)"
    }
}