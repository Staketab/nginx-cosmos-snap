## Download latest snapshot (using the example of Desmos Mainnet)  
Stop Desmos service  
```
systemctl stop desmos.service
```  

Remove old data in directory `~/.desmos/data`  
```
rm -rf ~/.desmos/data
mkdir -p ~/.desmos/data
cd ~/.desmos/data
```

Download snapshot through `aria2c`  
```bash
SNAP_LINK="https://services.staketab.com/desmos/"
SNAP_NAME=$(curl -s ${SNAP_LINK} | egrep -o ">desmos-mainnet.*tar" | tr -d ">")
aria2c -x2 ${SNAP_LINK}${SNAP_NAME}
tar -xf ${SNAP_NAME}
rm -rf ${SNAP_NAME}
```

Download snapshot through `wget`  
```bash
SNAP_NAME=$(curl -s https://services.staketab.com/desmos/ | egrep -o ">desmos-mainnet.*tar" | tr -d ">")
wget -O - https://services.staketab.com/desmos/${SNAP_NAME} | tar xf -
```

Start service and check logs  
```
systemctl start desmos.service
journalctl -u desmos.service -f
```
