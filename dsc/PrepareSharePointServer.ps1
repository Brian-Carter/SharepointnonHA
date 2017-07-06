configuration PrepareSharePointServer
{


    Import-DSCResource -ModuleName xPSDesiredStateConfiguration, xDisk, cDisk


    Node localhost
    {
        LocalConfigurationManager
        {
            ConfigurationMode = 'ApplyOnly'
            RebootNodeIfNeeded = $true
        }
        xWaitforDisk Disk2
        {
            DiskNumber = 2
            RetryIntervalSec = 30
            RetryCount = 60
        }
        cDiskNoRestart SPDataDisk
        {
            DiskNumber = 2
            DriveLetter = "F"
            DependsOn = "[xWaitforDisk]Disk2"
        }
        WindowsFeature ADPS
        {
            Name = "RSAT-AD-PowerShell"
            Ensure = "Present"
            DependsOn = "[cDiskNoRestart]SPDataDisk"
        }
    }
}

