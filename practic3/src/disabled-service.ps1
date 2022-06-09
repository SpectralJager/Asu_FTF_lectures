Write-Host "Change Virtual Memory"
$physicalmem=get-wmiobject  Win32_ComputerSystem | % {$_.TotalPhysicalMemory}
$physicalmem1=[math]::Round($physicalmem / 1048576)
$computersys = Get-WmiObject Win32_ComputerSystem -EnableAllPrivileges;
$computersys.AutomaticManagedPagefile = $False;
$computersys.Put();
$pagefile = Get-WmiObject -Query "Select * From Win32_PageFileSetting Where Name like '%pagefile.sys'";
$newphysicalmem = $physicalmem1*2
$pagefile.InitialSize = $newphysicalmem;
$pagefile.MaximumSize = $newphysicalmem;
$newpagefile=$pagefile.Put();

Write-Host "'$physicalmem1' old, '$newphysicalmem' new"

# Set-ExecutionPolicy RemoteSigned
Write-Host "Disable Hyper-V Service"
# Интерфейс гостевой службы Hyper-V
Set-Service vmicguestinterface -StartupType Disabled
# Служба пульса (Hyper-V)
Set-Service vmicheartbeat -StartupType Disabled
# Служба обмена данными (Hyper-V)
Set-Service vmickvpexchange -StartupType Disabled
# Служба виртуализации удаленных рабо...    
Set-Service vmicrdv -StartupType Disabled
# Служба завершения работы в качестве...            
Set-Service vmicshutdown -StartupType Disabled
# Служба синхронизации времени Hyper-V       
Set-Service vmictimesync -StartupType Disabled
# Служба Hyper-V PowerShell Direct       
Set-Service vmicvmsession -StartupType Disabled
# Служба запросов на теневое копирова...
Set-Service vmicvss -StartupType Disabled

Write-Host "Disable Bluetooth Service"
Set-Service bthserv -StartupType Disabled
Set-Service BluetoothUserService -StartupType Disable


Write-Host "Disable Live Tiles"
function Pin-Remove-App {    param(
        [string]$apptilename
    )
    try{
		((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() | ?{$_.Name -eq $apptilename}).Verbs() | ?{$_.Name.replace('&','') -match 'Von "Start" lösen|Unpin from Start'} | %{$_.DoIt()}
		Write-Host "App '$apptilename' unpinned from Start" -ForegroundColor Green
    }catch{
        #Write-Error "Error Pinning/Unpinning App! (App-Name correct?)"
		Write-Host "App '$apptilename' not found" -ForegroundColor Red
    }
}

#------ List of apps -------
$tiles = "Mail" ,
 "Microsoft Store" ,
 "Calendar" ,
 "Microsoft Edge" ,
 "Photos" ,
 "Cortana" ,
 "Weather" ,
 "Phone Companion" ,
 "Twitter" ,
 "Skype Video" ,
 "Skype" ,
 "Candy Crush Soda Saga" ,
 "Xbox" ,
 "Groove music" ,
 "Wallet" ,
 "Get Office" ,
 "Onenote" ,
 "News" , 
 "Camera" ,
 "3D Viewer" ,
 "Alarms & Clock" ,
 "Calendar" ,
 "Candy Crush Saga" ,
 "Candy Crush Friends Saga" ,
 "Feedback Hub" ,
 "Get Help" ,
 "Microsoft Solitaire Collection" ,
 "Minecraft for Windows 10" ,
 "Mixed Reality Portal" ,
 "Money" ,
 "Movies & TV" ,
 "Netflix" ,
 "People" ,
 "Scan" ,
 "Snip & Sketch" ,
 "Sports" ,
 "Sticky Notes" ,
 "Tips" ,
 "Voice Recorder" ,
 "Xbox Game Bar" ,
 "Your Phone"
 #------ End of list of apps -------
 
 foreach($tile in $tiles) {
	Pin-Remove-App $tile
 }
 
 Write-Host "Remove apps"
 
 $apps = "3dbuilder",
	"windowsalarms",
	"windowscalculator",
	"windowscommunicaitonsapps",
	"windowscamera",
	"officehub",
	"skypeapp",
	"getstarted",
	"zunemisic",
	"windowsmaps",
	"solitairecollection",
	"bingfinance",
	"zunevideo",
	"bingnews",
	"onenote",
	"people",
	"windowsphone",
	"photos",
	"windowsstore",
	"bingsports",
	"soundrecorder",
	"bingweather",
	"xboxapp",
	"549981c3f5f10",
	"XboxGamingOverlay"

foreach($app in $apps) {
	try{
		Get-AppxPackage -AllUsers -PackageTypeFilter Bundle -name *$app* | Remove-AppxPackage
		Write-Host "App '$app' removed" -ForegroundColor Green
    }catch{
		Write-Host "App '$app' not found or cant remove" -ForegroundColor Red
    }
 }

$confirmation=Read-host "Do you want to Restart the PC (Y/N)"
if($confirmation -eq 'N'){
	Write-host "The system restart is skipped by the user" -BackgroundColor DarkRed
}else{
	Write-Host "The system will be restarting ...." -BackgroundColor DarkGreen
	Restart-Computer -Force
}