#!/bin/bash/

# Create a new directory or use any directory
echo "-> Creating iredmail directory..."
mkdir /iredmail         

cd /iredmail
# create config file
echo "-> Checking for config file..."
FILE=.iredmail-docker.conf
if [ -f "$FILE" ]; then
    echo "<INFO> Config file exists!"
else
    echo "<INFO> No exisitng file!"
    echo "-> Creating config file..."
    touch iredmail-docker.conf
    echo "-> Generating server secrets & credentials..."
    echo HOSTNAME=mail.rgn.org.uk >> iredmail-docker.conf
    echo FIRST_MAIL_DOMAIN=rgn.org.uk >> iredmail-docker.conf
    # change domain admin password before running this script
    echo FIRST_MAIL_DOMAIN_ADMIN_PASSWORD=my-secret-password >> iredmail-docker.conf
    echo MLMMJADMIN_API_TOKEN=$(openssl rand -base64 32) >> iredmail-docker.conf
    echo ROUNDCUBE_DES_KEY=$(openssl rand -base64 24) >> iredmail-docker.conf
fi

cd /iredmail
echo "-> Checking for required directories..."
data_dir='/iredmail/data'
if [ -d $data_dir ]; then
    echo "<INFO> /iredmail/data exists"
else
    echo "-> Creating /iredmail/data ..."
    mkdir -p data
fi

cd /iredmail/data
dirArray=("backup-mysql" "clamav" "custom" "imapsieve_copy" "mailboxes" "mlmmj" "mlmmj-archive" "mysql" "sa_rules" "ssl" "postfix_queue")

for d in ${dirArray[@]}; do
    if [ ! -d $d ]; then
        mkdir -p $d
    fi
done
# mkdir -p data/{backup-mysql,clamav,custom,imapsieve_copy,mailboxes,mlmmj,mlmmj-archive,mysql,sa_rules,ssl,postfix_queue}
