#!/bin/bash

#logo 

echo -e "\033[31m

                                                                               

   __  __                                  
  / /_/ /_  ________  ___  _________  ____ 
 / __/ __  / ___/ _  / _  / ___/ __  / __ \
/ /_/ / / / /  /  __/  __/ /__/ /_/ / / / /
\__/_/ /_/_/    ___/ ___/ ___/ ____/_/ /_/ 
                                           

                                                                                
                                                    
"

#create folder 

now=`date +”%m/%d/%Y”`
folder= "$now"
echo -e "\033[0mCreating folder: $folder"
mkdir $folder 


#target site

if [ "$1" == ""]
    echo -e "\033[31mPlease target site as first argument!"
else
    echo -e "\033[31mTarget site: $1"

#subdomains
python /tools/r3/included_tools/sublister/sublist3r.py $1 > $folder/subdomain.txt
touch $folder/subdomains.txt > $folder/subdomains.txt
python onlysubdomains.py $folder $1
rm $folder/subdomain.txt

while read p; do
  echo -e "\033[92m$p"
  sleep 0.05
done <$folder/subdomains.txt

#check if domains respond

python responding_domains.py $folder
