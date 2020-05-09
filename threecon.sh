#!/bin/bash

#logo 

echo -e "\033[31m

                                                                               

   __  __                                  
  / /_/ /_  ________  ___  _________  ____
 / __/ __  / ___/ _  / _  / ___/ __  / __ \\
/ /_/ / / / /  /  __/  __/ /__/ /_/ / / / /
\__/_/ /_/_/   \\___/\\___/\\___/\\____/_/ /_/ 
                                           

                                                                                
                                                    
"

#create folder 
today=$(date +"%Y-%m-%d")
folder="3con-$today"
echo -e "\033[0mCreating folder: $folder"
mkdir $folder 


#target site

if [ -z $1 ]; 
then
    echo -e "\033[31mPlease target site as first argument!"
    exit 0
else
    echo -e "\033[31mTarget site: $1"
fi

#subdomains
echo -e "\033[34m

Bruteforcing subdomains: (this can take a while)"

python /tools/r3/included_tools/sublister/sublist3r.py -d $1 > $folder/subdomain.txt
touch $folder/subdomains.txt > $folder/subdomains.txt
python onlysubdomains.py $folder $1
rm $folder/subdomain.txt

while read p; do
  echo -e "\033[92m$p"
  sleep 0.05
done <$folder/subdomains.txt

#check if domains respond
echo -e "\033[34m

Checking if domains respond; green= response, red= no response: (this can take a while)"
python responding_domains.py $folder


#taking screenshots of all the responding sites
echo -e "\033[34m

Taking screenshots of all responding sites:\033[92m"
python /tools/r3/included_tools/webscreenshot/webscreenshot.py -i $folder/responding_domains.txt
mkdir $folder/screenshots
mv screenshots/* $folder/screenshots/
rmdir screenshots

#nmap scan
echo -e "\033[34m

Nmap Scan:"
nmap -v $1 > $folder/fullnmapscan.txt
touch $folder/cleaned_nmap_scan.txt > $folder/cleaned_nmap_scan.txt
python clean_nmap_scan.py $folder

while read p; do
   echo -e "\033[92m$p"
   sleep 0.05
done <$folder/cleaned_nmap_scan.txt
