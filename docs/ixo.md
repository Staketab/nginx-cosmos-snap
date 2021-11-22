## Download latest snapshot (using the example of IXO)  
Stop IXO service  
`systemctl stop ixod.service`  

Remove old data in directory `~/.ixod/data`  
```
rm -rf ~/.ixod/data; \
mkdir -p ~/.ixod/data; \
cd ~/.ixod/data
```

Download snapshot  
```bash
SNAP_NAME=$(curl -s http://cosmos-snap.staketab.com/ixo/ | egrep -o ">impacthub-3.*tar" | tr -d ">"); \
wget -O - http://cosmos-snap.staketab.com/ixo/${SNAP_NAME} | tar xf -
```

Start service and check logs  
```
systemctl start ixod.service; \
journalctl -u ixod.service -f --no-hostname
```
