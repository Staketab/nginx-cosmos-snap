## Download latest snapshot (using the example of Evmos MAINNET)  
Stop Evmos service  
```
systemctl stop evmosd.service
```  

Remove old data in directory `~/.evmosd/data`  
```
rm -rf ~/.evmosd/data; \
mkdir -p ~/.evmosd/data; \
cd ~/.evmosd/data
```

Download snapshot through `aria2c`  
```bash
SNAP_LINK="https://cosmos-snap.staketab.com/evmos/"
SNAP_NAME=$(curl -s ${SNAP_LINK} | egrep -o ">evmos_9001-1.*tar" | tr -d ">")
aria2c -x2 ${SNAP_LINK}${SNAP_NAME}
tar -xf ${SNAP_NAME}
rm -rf ${SNAP_NAME}
```

Download snapshot through `wget`  
```bash
SNAP_NAME=$(curl -s https://cosmos-snap.staketab.com/evmos/ | egrep -o ">evmos_9001-1.*tar" | tr -d ">"); \
wget -O - https://cosmos-snap.staketab.com/evmos/${SNAP_NAME} | tar xf -
```

Start service and check logs  
```
systemctl start evmosd.service
journalctl -u evmosd.service -f
```
