import sys

f = open(sys.argv[1]+'/subdomain.txt', 'r')
g = open(sys.argv[1]+'/subdomains.txt', 'a')
write = False
for line in f:
    if 'www.'+sys.argv[2] in line:
        write = True
    if write == True:
        g.write(line.replace('\x1b[92m','').replace('\x1b[0m','')) 
