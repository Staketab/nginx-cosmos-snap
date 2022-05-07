## Download latest snapshot (using the example of Gravity-Bridge Mainnet)  
Stop Gravity-Bridge service  
```
systemctl stop gravity.service
```  

Remove old data in directory `~/.gravity/data`  
```
rm -rf ~/.gravity/data; \
mkdir -p ~/.gravity/data; \
cd ~/.gravity/data
```

Download snapshot through `aria2c`  
```bash
SNAP_LINK="https://services.staketab.com/gravity-bridge/"
SNAP_NAME=$(curl -s ${SNAP_LINK} | egrep -o ">gravity-bridge-3.*tar" | tr -d ">")
aria2c -x2 ${SNAP_LINK}${SNAP_NAME}
tar -xf ${SNAP_NAME}
rm -rf ${SNAP_NAME}
```

Download snapshot through `wget`  
```bash
SNAP_NAME=$(curl -s https://services.staketab.com/gravity-bridge/ | egrep -o ">gravity-bridge-3.*tar" | tr -d ">"); \
wget -O - https://services.staketab.com/gravity-bridge/${SNAP_NAME} | tar xf -
```

Start service and check logs  
```
systemctl start gravity.service; \
journalctl -u gravity.service -f --no-hostname
```
