## Download latest snapshot (using the example of IXO)  
Stop IXO service  
`systemctl stop ixod.service`  

Remove old data in directory `~/.ixod/data`  
```
rm -rf ~/.ixod/data; \
mkdir -p ~/.ixod/data; \
cd ~/.ixod/data
```

Download snapshot through `aria2c`  
```bash
SNAP_LINK="https://cosmos-snap.staketab.com/ixo/"
SNAP_NAME=$(curl -s ${SNAP_LINK} | egrep -o ">impacthub-3.*tar" | tr -d ">")
aria2c -x2 ${SNAP_LINK}${SNAP_NAME}
tar -xf ${SNAP_NAME}
rm -rf ${SNAP_NAME}
```

Download snapshot through `wget`  
```bash
SNAP_NAME=$(curl -s https://cosmos-snap.staketab.com/ixo/ | egrep -o ">impacthub-3.*tar" | tr -d ">"); \
wget -O - https://cosmos-snap.staketab.com/ixo/${SNAP_NAME} | tar xf -
```

Start service and check logs  
```
systemctl start ixod.service; \
journalctl -u ixod.service -f --no-hostname
```
