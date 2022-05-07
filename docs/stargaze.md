## Download latest snapshot (using the example of Stargaze)  
Stop Stargaze service  
```
systemctl stop starsd.service
```  

Remove old data in directory `~/.starsd/data`  
```
rm -rf ~/.starsd/data; \
mkdir -p ~/.starsd/data; \
cd ~/.starsd/data
```

Download snapshot through `aria2c`  
```bash
SNAP_LINK="https://services.staketab.com/stargaze/"
SNAP_NAME=$(curl -s ${SNAP_LINK} | egrep -o ">stargaze-1.*tar" | tr -d ">")
aria2c -x2 ${SNAP_LINK}${SNAP_NAME}
tar -xf ${SNAP_NAME}
rm -rf ${SNAP_NAME}
```

Download snapshot through `wget`  
```bash
SNAP_NAME=$(curl -s https://services.staketab.com/stargaze/ | egrep -o ">stargaze-1.*tar" | tr -d ">"); \
wget -O - https://services.staketab.com/stargaze/${SNAP_NAME} | tar xf -
```

Start service and check logs  
```
systemctl start starsd.service; \
journalctl -u starsd.service -f --no-hostname
```
