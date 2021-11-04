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

Download snapshot  
```bash
SNAP_NAME=$(curl -s http://cosmos-snap.staketab.com/sifchain/ | egrep -o ">sifchain-1.*tar" | tr -d ">"); \
wget -O - http://cosmos-snap.staketab.com/sifchain/${SNAP_NAME} | tar xf -
```

Start service and check logs  
```
systemctl start sifnoded.service; \
journalctl -u sifnoded.service -f --no-hostname
```
