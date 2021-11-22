## Download latest snapshot (using the example of Comdex TESTNET)  
Stop Comdex service  
```
systemctl stop comdex.service
```  

Remove old data in directory `~/.comdex/data`  
```
rm -rf ~/.comdex/data; \
mkdir -p ~/.comdex/data; \
cd ~/.comdex/data
```

Download snapshot  
```bash
SNAP_NAME=$(curl -s http://cosmos-snap.staketab.com/comdex/ | egrep -o ">comets-test.*tar" | tr -d ">"); \
wget -O - http://cosmos-snap.staketab.com/comdex/${SNAP_NAME} | tar xf -
```

Start service and check logs  
```
systemctl start comdex.service; \
journalctl -u comdex.service -f --no-hostname
```
