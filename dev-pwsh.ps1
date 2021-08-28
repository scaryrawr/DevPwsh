# Assume amd64.
$arch = '64'

# Check for arm64
if ("$env:PROCESSOR_ARCHITECTURE" -eq 'ARM64') {
    # Assume x64 emulation
    $arch = 'amd64_arm64'
}

# Load environment variables from running vcvars
# Currently hard coded for VS2022 Preview
$command = "C:\Program Files\Microsoft Visual Studio\2022\Preview\VC\Auxiliary\Build\vcvars${arch}.bat"
cmd /c "`"$command`"&set" | ForEach-Object {
    if ($_ -match '=') {
        $vars = $_.split('=')
        Set-Item -Force -Path "env:$($vars[0])" -Value "$($vars[1])"
    }
    else {
        # Log information so user knows what environment they were set up with
        Write-Output $_
    }
}