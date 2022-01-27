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

Download snapshot through `aria2c`  
```bash
SNAP_LINK="https://cosmos-snap.staketab.com/idep/"
SNAP_NAME=$(curl -s ${SNAP_LINK} | egrep -o ">SanfordNetwork.*tar" | tr -d ">")
aria2c -x2 ${SNAP_LINK}${SNAP_NAME}
tar -xf ${SNAP_NAME}
rm -rf ${SNAP_NAME}
```

Download snapshot through `wget`   
```bash
SNAP_NAME=$(curl -s https://cosmos-snap.staketab.com/idep/ | egrep -o ">SanfordNetwork.*tar" | tr -d ">"); \
wget -O - https://cosmos-snap.staketab.com/idep/${SNAP_NAME} | tar xf -
```

Start service and check logs  
```
systemctl start iond.service; \
journalctl -u iond.service -f --no-hostname
```
