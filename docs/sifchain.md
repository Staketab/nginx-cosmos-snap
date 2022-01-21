## Download latest snapshot (using the example of Sifchain)  
Stop Sifchain service  
```
systemctl stop sifnoded.service
```  

Remove old data in directory `~/.sifnoded/data`  
```
rm -rf ~/.sifnoded/data; \
mkdir -p ~/.sifnoded/data; \
cd ~/.sifnoded/data
```

Download snapshot through `aria2c`  
```bash
SNAP_LINK="http://cosmos-snap.staketab.com/sifchain/"
SNAP_NAME=$(curl -s ${SNAP_LINK} | egrep -o ">sifchain-1.*tar" | tr -d ">")
aria2c -x2 ${SNAP_LINK}${SNAP_NAME}
tar -xf ${SNAP_NAME}
rm -rf ${SNAP_NAME}
```

Download snapshot through `wget`  
```bash
SNAP_NAME=$(curl -s http://cosmos-snap.staketab.com/sifchain/ | egrep -o ">sifchain-1.*tar" | tr -d ">"); \
wget -O - http://cosmos-snap.staketab.com/sifchain/${SNAP_NAME} | tar xf -
```

Start service and check logs  
```
systemctl start sifnoded.service; \
journalctl -u sifnoded.service -f --no-hostname
```
