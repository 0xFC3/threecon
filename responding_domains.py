import requests
import sys

f = open(sys.argv[1]+'/subdomains.txt', 'r')
g = open(sys.argv[1]+'/responding_domains.txt', 'a')
y = open(sys.argv[1]+'/not_responding_domains.txt', 'a')

for line in f:
    try:
        url = 'http://'+line.strip().replace('www.','')
        headers = {'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36'}
        request = requests.get(url, headers=headers)
    
        if request.status_code == 200:
            g.write(line)
            print('\x1b[92m' + line)
        else:
            y.write(line)
            print('\x1b[31m' + line)
    except:
        y.write(line)
        print('\x1b[31m' + line)



