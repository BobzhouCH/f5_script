#! /bin/bash
ucs_file_name=$(echo $HOSTNAME | cut -d'.' -f1)-$(date +%H%M-%m%d%y)
tmsh save sys ucs $ucs_file_name
cd /var/local/ucs/

/bin/expect << EOD 
spawn scp $ucs_file_name.ucs ftp@10.1.1.7:/home/ftp/
expect {
   "password:" {set timeout 300; send "f5test.com\r";}
   "yes/no" {send "yes\r"; exp_continue;}
}  

expect eof
