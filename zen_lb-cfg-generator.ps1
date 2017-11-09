#this script will generate .cfg files for zen load balancer which can be used to create "farms"
#this script will take input from a csv file(example included with script) and generate cfg files
#based on the template cfg file. The script was used for create vips or farms with 2 servers in the pool
#but could be modified to do 1 server in the pool. Once the cfg are generated you can copy them over to
#/usr/local/zenloadbalancer/config on the zenloadbalancer server and then restart the zenloadbalancer service 
#and the farms should be created. You will need to create the VIP interfaces before you restart the service
#
#
#pthomson - April 9, 2015
#
#
#NAME = name of the VIP
#LOCALPORT = random number for the 127.0.0.1 local port. Still not 100% how this is used 
#VIP = VIP IP address
#SRCPRT = VIP port number 
#DESTIP = IP address of the server in the vip pool
#DESTPORT = port on the destination server in the vip pool



$csv = Read-host "Enter the name of the .CSV file located in the same folder as this script"
$vips = Import-Csv $csv

foreach ($vip in $vips) {
    
    (Get-Content .\template.cfg) -replace "NAME",$vip.Name | Set-Content "$($vip.name)_pen.cfg"
    (Get-Content "$($vip.name)_pen.cfg") -replace "LOCALPORT",$vip.lport | Set-Content "$($vip.name)_pen.cfg"
    (Get-Content "$($vip.name)_pen.cfg") -replace "VIP",$vip.vip | Set-Content "$($vip.name)_pen.cfg"
    (Get-Content "$($vip.name)_pen.cfg") -replace "SRCPRT",$vip.Source | Set-Content "$($vip.name)_pen.cfg"
    (Get-Content "$($vip.name)_pen.cfg") -replace "DESTIP",$vip.ip | Set-Content "$($vip.name)_pen.cfg"
    (Get-Content "$($vip.name)_pen.cfg") -replace "DEST2IP",$vip.ip2 | Set-Content "$($vip.name)_pen.cfg"
    (Get-Content "$($vip.name)_pen.cfg") -replace "DESTPORT",$vip.dport | Set-Content "$($vip.name)_pen.cfg"
    
    }