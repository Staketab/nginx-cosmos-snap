## Download latest snapshot (using the example of Kichain)  
Stop Kichain service  
```
systemctl stop ki-validator.service
```  

Remove old data in directory `/srv/ki/kid/data`  
```
rm -rf /srv/ki/kid/data; \
mkdir -p /srv/ki/kid/data; \
cd /srv/ki/kid/data
```

Download snapshot  
```bash
SNAP_NAME=$(curl -s http://mercury-nodes.net/kichain-snaps/ | egrep -o ">kichain-2.*tar" | tr -d ">"); \
wget -O - http://mercury-nodes.net/kichain-snaps/${SNAP_NAME} | tar xf -
```

Start service and check logs  
```
systemctl start ki-validator.service; \
journalctl -u ki-validator.service -f --no-hostname
```
