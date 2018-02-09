$Functions = Get-ChildItem -path "$PSScriptRoot\Functions\*.ps1"

foreach ($function in $Functions) {
    . $function.fullname
}
