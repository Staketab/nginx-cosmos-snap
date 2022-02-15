## Download latest snapshot (using the example of Umee Mainnet)  
Stop Umee service  
```
systemctl stop umeed.service
```  

Remove old data in directory `~/.umee/data`  
```
rm -rf ~/.umee/data; \
mkdir -p ~/.umee/data; \
cd ~/.umee/data
```

Download snapshot through `aria2c`  
```bash
SNAP_LINK="https://cosmos-snap.staketab.com/umee/"
SNAP_NAME=$(curl -s ${SNAP_LINK} | egrep -o ">umee-1.*tar" | tr -d ">")
aria2c -x2 ${SNAP_LINK}${SNAP_NAME}
tar -xf ${SNAP_NAME}
rm -rf ${SNAP_NAME}
```

Download snapshot through `wget`  
```bash
SNAP_NAME=$(curl -s https://cosmos-snap.staketab.com/umee/ | egrep -o ">umee-1.*tar" | tr -d ">"); \
wget -O - https://cosmos-snap.staketab.com/umee/${SNAP_NAME} | tar xf -
```

Start service and check logs  
```
systemctl start umeed.service; \
journalctl -u umeed.service -f --no-hostname
```
