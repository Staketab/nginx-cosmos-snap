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

Download snapshot through `aria2c`  
```bash
SNAP_LINK="https://cosmos-snap.staketab.com/comdex/"
SNAP_NAME=$(curl -s ${SNAP_LINK} | egrep -o ">comdex-1.*tar" | tr -d ">")
aria2c -x2 ${SNAP_LINK}${SNAP_NAME}
tar -xf ${SNAP_NAME}
rm -rf ${SNAP_NAME}
```

Download snapshot through `wget`  
```bash
SNAP_NAME=$(curl -s https://cosmos-snap.staketab.com/comdex/ | egrep -o ">comets-test.*tar" | tr -d ">"); \
wget -O - https://cosmos-snap.staketab.com/comdex/${SNAP_NAME} | tar xf -
```

Start service and check logs  
```
systemctl start comdex.service; \
journalctl -u comdex.service -f --no-hostname
```
