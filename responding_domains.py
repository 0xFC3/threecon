import requests
import sys

f = open(sys.argv[1]+'/subdomains.txt', 'r')
g = open(sys.argv[1]+'/responding_domains.txt', 'a')
y = open(sys.argv[1]+'/not_responding_domains.txt', 'a')

for line in f:
    try:
        request = requests.get('http://'+line.strip())
        if request.status_code == 200:
            g.write(line)
            print('\x1b[92m' + line)
        else:
            y.write(line)
            print('\x1b[31m' + line)
    except:
        y.write(line)
        print('\x1b[31m' + line)



