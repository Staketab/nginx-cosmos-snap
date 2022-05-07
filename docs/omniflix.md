## Download latest snapshot (using the example of Omniflix MAINNET)  
Stop Omniflix service  
```
systemctl stop omniflixhubd.service
```  

Remove old data in directory `~/.omniflixhub/data`  
```
rm -rf ~/.omniflixhub/data; \
mkdir -p ~/.omniflixhub/data; \
cd ~/.omniflixhub/data
```

Download snapshot through `aria2c`  
```bash
SNAP_LINK="https://services.staketab.com/omniflix/"
SNAP_NAME=$(curl -s ${SNAP_LINK} | egrep -o ">omniflixhub-1.*tar" | tr -d ">")
aria2c -x2 ${SNAP_LINK}${SNAP_NAME}
tar -xf ${SNAP_NAME}
rm -rf ${SNAP_NAME}
```

Download snapshot through `wget`  
```bash
SNAP_NAME=$(curl -s https://services.staketab.com/omniflix/ | egrep -o ">omniflixhub-1.*tar" | tr -d ">"); \
wget -O - https://services.staketab.com/omniflix/${SNAP_NAME} | tar xf -
```

Start service and check logs  
```
systemctl start omniflixhubd.service
journalctl -u omniflixhubd.service -f
```
