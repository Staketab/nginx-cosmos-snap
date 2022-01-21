## Download latest snapshot (using the example of Medibloc)  
Stop Medibloc service  
```
systemctl stop panacead.service
```  

Remove old data in directory `~/.panacea/data`  
```
rm -rf ~/.panacea/data; \
mkdir -p ~/.panacea/data; \
cd ~/.panacea/data
```

Download snapshot through `aria2c`  
```bash
SNAP_LINK="http://cosmos-snap.staketab.com/medibloc/"
SNAP_NAME=$(curl -s ${SNAP_LINK} | egrep -o ">panacea-3.*tar" | tr -d ">")
aria2c -x2 ${SNAP_LINK}${SNAP_NAME}
tar -xf ${SNAP_NAME}
rm -rf ${SNAP_NAME}
```

Download snapshot through `wget`  
```bash
SNAP_NAME=$(curl -s http://cosmos-snap.staketab.com/medibloc/ | egrep -o ">panacea-3.*tar" | tr -d ">"); \
wget -O - http://cosmos-snap.staketab.com/medibloc/${SNAP_NAME} | tar xf -
```

Start service and check logs  
```
systemctl start panacead.service; \
journalctl -u panacead.service -f --no-hostname
```
