$hosts = @("google.ie", "aafs01")
$threshold = 100  # Set the threshold for ping delay (in ms)

while ($true) {
    $jobs = @()

    # Start concurrent ping jobs
    foreach ($hostname in $hosts) {
        $jobs += Start-Job -ScriptBlock {
            param ($hostname)
            try {
                # Perform the ping test
                $ping = Test-Connection -ComputerName $hostname -Count 1 -ErrorAction Stop
                return @{ Hostname = $hostname; Delay = $ping.ResponseTime }
            } catch {
                return @{ Hostname = $hostname; Delay = "failed" }
            }
        } -ArgumentList $hostname
    }

    # Wait for all jobs to finish and collect results
    $results = $jobs | ForEach-Object {
        $job = $_
        $result = Receive-Job -Job $job -Wait
        Remove-Job -Job $job

        $result
    }

    # Get current timestamp
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    
    # Process the results and output the formatted ping times
    $output = "[$timestamp] "

    foreach ($result in $results) {
        if ($result.Delay -eq "failed") {
            $output += "$($result.Hostname) failed "
        } elseif ($result.Delay -gt $threshold) {
            $output += "$($result.Hostname) >$threshold" + "ms "
        } else {
            $output += "$($result.Hostname) $($result.Delay)ms "
        }
    }

    Write-Output $output.Trim()

    # Wait for 2 seconds before next iteration
    Start-Sleep -Seconds 2
}