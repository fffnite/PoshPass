function Get-Data {

    [CmdletBinding(PositionalBinding = $false)]

    Param(
        # Sets which server to connect to.
        [Parameter(Mandatory = $true)]
        [string]
        $Server,

        # Insert Access Token for data query.
        [Parameter(Mandatory = $true)]
        [string]
        $AccessToken,

        # Set which PASS module to connect to.
        [Parameter(Mandatory = $true)]
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

        # Iterates through every next link available
        [Parameter()]
        [switch]
        $All
    )

    begin {
        # Create a dynamic list to store output objects
        $Data = [system.collections.generic.list[Object]]::new() 
    }

    process {
        if ($Expand) {$Expand = '&$expand=' + $Expand} 
        if ($Filter) {$Filter = '&$filter=' + $Filter} 
        if ($Select) {$Select = '&$select=' + $Select}
        if ($OrderBy) {$OrderBy = '&$orderby=' + $OrderBy}
        if ($Top) {$Top = '&$top=' + $Top}
        if ($skip) {$Skip = '&$skip=' + $Skip}
        if ($Count) {$Count = '&$count=' + $Count}
        $Uri = "https://$Server/Wcbs.API/api$Module" + "?" + "$Expand" + "$Filter" + "$Select" + "$OrderBy" + "$Top" + "$Skip" + "$Count"

        $get = @{
            method  = 'Get'
            Headers = @{
                "authorization" = "Bearer $AccessToken"
                "accept"        = "application/json"
            }
        }
        $results = Invoke-RestMethod @get -uri $uri
        $Data.add($results)

        if ($All) {
            while ($results.'@odata.nextlink') {
                $Results = Invoke-RestMethod @get -uri $results.'@odata.nextlink'
                $Data.add($results)
            }
        }
    }
    
    end {
        $Data
    }
}

