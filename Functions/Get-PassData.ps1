function Get-PassData {

    [CmdletBinding(PositionalBinding = $false)]

    Param(
        # Sets which server to connect to.
        [Parameter()]
        [string]
        $Server,

        # Insert Access Token for data query.
        [Parameter()]
        [string]
        $AccessToken,

        # Set which PASS module to connect to.
        [Parameter()]
        [string]
        $Module,

        # Expands related entities inline.
        [Parameter()]
        [string]
        $Expand,

        # Filters the results, based on a Boolean condition.
        [Parameter()]
        [string]
        $Filter,

        # Selects which properties to include in the response.
        [Parameter()]
        [string]
        $Select,

        # Sorts the results.
        [Parameter()]
        [string]
        $OrderBy,

        # Limits to top X amount of records.
        [Parameter()]
        [string]
        $Top,

        # Skips X records when querying data.
        [Parameter()]
        [string]
        $Skip,

        # Counts the amount of records returned. 'True' or 'False'.
        [Parameter()]
        [string]
        $Count,

        # Parameter help description
        [Parameter()]
        [string]
        $NextLink
    )

    if ($Expand) {$Expand = '&$expand=' + $Expand} 
    if ($Filter) {$Filter = '&$filter=' + $Filter} 
    if ($Select) {$Select = '&$select=' + $Select}
    if ($OrderBy) {$OrderBy = '&$orderby=' + $OrderBy}
    if ($Top) {$Top = '&$top=' + $Top}
    if ($skip) {$Skip = '&$skip=' + $Skip}
    if ($Count) {$Count = '&$count=' + $Count}

    $PassDataParams = @{
        Uri     = "https://$Server/Wcbs.API/api$Module" + "?" + "$Expand" + "$Filter" + "$Select" + "$OrderBy" + "$Top" + "$Skip" + "$Count"
        method  = 'Get'
        Headers = @{
            "authorization" = "Bearer $AccessToken"
            "accept"        = "application/json"
        }
    }

    if ($NextLink) {
        $PassDataParams = @{
            Uri     = "$NextLink"
            method  = 'Get'
            Headers = @{
                "authorization" = "Bearer $AccessToken"
                "accept"        = "application/json"
            }
        }
    }

    Invoke-RestMethod @PassDataParams -Verbose
}