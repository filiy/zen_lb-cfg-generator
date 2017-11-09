#This script creates the interface files required for new VIPs on ZEN Load Balancer
#The script is just doing a find and replace 
#You'll need to generate a csv file that has all the unique VIP IPs 
#ips-template.csv is a quick template file to reference
#I just pulled all the unique IPs from the environment config sheets and dump them into the template file
#Once you have all the files generated you'll need to scp them over to the load balancer
#once on the load balancer you'll need to rename all the files as the format of the file needs to be this
#if_eth1:92_conf but Windows doesn't allow : in the file name. From the linux command line run
#rename -v 's/\./\:/' * in the directory only containing the files you want to rename 
#update the if-template_conf file for whatever eth# interface on the LB you are creating VIPs for
#
#
#pthomson - May 26, 2015
#
#

$csv = Read-host "Enter the name of the .CSV file located in the same folder as this script"
$vips = Import-Csv $csv
$a = 1

foreach ($vip in $vips) {
    (Get-Content .\if-template_conf) -replace "XX",$a | Set-Content "if_eth3.$($a)_conf"
    (Get-Content "if_eth3.$($a)_conf") -replace "IP",$vip.vip | Set-Content "if_eth3.$($a)_conf"
    
    $a++
}