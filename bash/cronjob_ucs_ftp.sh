#! /bin/bash
ucs_file_name=$(echo $HOSTNAME | cut -d'.' -f1)-$(date +%H%M-%m%d%y)
tmsh save sys ucs $ucs_file_name
cd /var/local/ucs/

/bin/expect << EOD 
spawn ftp 10.1.1.7
expect {
   "Name" { send "ftp\r";}
}
expect {
   "Password:" { send "f5test.com\r";}
}
expect {
   "ftp>" { send "put $ucs_file_name.ucs\r";}
}
expect {
   "ftp>" { send "bye\r";}
}  

expect eof