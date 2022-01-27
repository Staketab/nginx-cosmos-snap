## Download latest snapshot (using the example of Axelar MAINNET)  
Stop Axelar service  
```
systemctl stop axelard.service
```  

Remove old data in directory `~/.axelar/data`  
```
rm -rf ~/.axelar/data; \
mkdir -p ~/.axelar/data; \
cd ~/.axelar/data
```

Download snapshot through `aria2c`  
```bash
SNAP_LINK="http://cosmos-snap.staketab.com/axelar/"
SNAP_NAME=$(curl -s ${SNAP_LINK} | egrep -o ">axelar-dojo-1.*tar" | tr -d ">")
aria2c -x2 ${SNAP_LINK}${SNAP_NAME}
tar -xf ${SNAP_NAME}
rm -rf ${SNAP_NAME}
```

Download snapshot through `wget`  
```bash
SNAP_NAME=$(curl -s http://cosmos-snap.staketab.com/axelar/ | egrep -o ">axelar-dojo-1.*tar" | tr -d ">"); \
wget -O - http://cosmos-snap.staketab.com/comdex/${SNAP_NAME} | tar xf -
```

Start service and check logs  
```
systemctl start axelard.service; \
journalctl -u axelard.service -f --no-hostname
```
