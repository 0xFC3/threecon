import sys

f = open(sys.argv[1]+'/fullnmapscan.txt', 'r')
g = open(sys.argv[1]+'/cleaned_nmap_scan.txt', 'a')

write = False
for line in f:
    if 'PORT     STATE SERVICE' in line:
        write = True
    if 'Read data files from' in line:
        write = False
    if write == True:
        g.write(line)
    
