## Download latest snapshot (using the example of Idep Sanford TESTNET)  
Stop Idep service  
```
systemctl stop iond.service
```  

Remove old data in directory `~/.ion/data`  
```
rm -rf ~/.ion/data; \
mkdir -p ~/.ion/data; \
cd ~/.ion/data
```

Download snapshot  
```bash
SNAP_NAME=$(curl -s http://cosmos-snap.staketab.com/idep/ | egrep -o ">SanfordNetwork.*tar" | tr -d ">"); \
wget -O - http://cosmos-snap.staketab.com/idep/${SNAP_NAME} | tar xf -
```

Start service and check logs  
```
systemctl start iond.service; \
journalctl -u iond.service -f --no-hostname
```
