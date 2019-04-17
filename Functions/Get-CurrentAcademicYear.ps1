function Get-CurrentAcademicYear {
    [CmdletBinding()]
    
    Param (
        # Server to connect to
        [Parameter(Mandatory = $true)]
        [string]
        $Server,
        
        # Access token for API
        [parameter(Mandatory = $true)]
        [string]
        $AccessToken,

        # School ID to query
        [parameter()]
        [int]
        $SchoolId = 1
    )

    Process {
        # Base get request
        $Get = @{
            Server = "$server"
            AccessToken = "$AccessToken"
        }
        # Get Current Academic year
        $CAY = (Get-Data @Get -Module "/schools($SchoolId)/CurrentAcademicYear").value.academicYearCode
        # Get calendar info based on the Current Academic Year
        $GetCal = @{
            Module = "/schools($SchoolID)/SchoolCalendars"
            Filter = "AcademicYear eq $CAY"
        }
        $YD = (Get-PassData @Get @GetCal).value
    }
    
    End {$YD}
}
