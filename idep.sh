#!/bin/bash
CHAIN_ID="Test-Denali"
SNAP_PATH="$HOME/nginx/cosmos-snapshots/idep/"
LOG_PATH="$HOME/nginx/cosmos-snapshots/idep/idep_log.txt"
DATA_PATH="$HOME/.ion/data/"
SERVICE_NAME="iond.service"
RPC_ADDRESS="http://127.0.0.1:56657"
SNAP_NAME=$(echo "${CHAIN_ID}_$(date '+%Y-%m-%d').tar")
OLD_SNAP=$(ls ${SNAP_PATH} | egrep -o "${CHAIN_ID}.*tar")


now_date() {
    echo -n $(TZ=":Europe/Moscow" date '+%Y-%m-%d_%H:%M:%S')
}

log_this() {
    YEL='\033[1;33m' # yellow
    NC='\033[0m'     # No Color
    local logging="$@"
    printf "|$(now_date)| $logging\n" | sudo tee -a ${LOG_PATH}
}

LAST_BLOCK_HEIGHT=$(curl -s ${RPC_ADDRESS}/status | jq -r .result.sync_info.latest_block_height)
sudo touch ${LOG_PATH}
sudo chmod 777 ${LOG_PATH}
log_this "LAST_BLOCK_HEIGHT ${LAST_BLOCK_HEIGHT}"

log_this "Stopping ${SERVICE_NAME}"
sudo systemctl stop ${SERVICE_NAME}; echo $? >> ${LOG_PATH}

log_this "Creating new snapshot"
time tar cf ${HOME}/${SNAP_NAME} -C ${DATA_PATH} . &>>${LOG_PATH}

log_this "Starting ${SERVICE_NAME}"
sudo systemctl start ${SERVICE_NAME}; echo $? >> ${LOG_PATH}

log_this "Removing old snapshot(s):"
cd ${SNAP_PATH}
sudo rm -fv ${OLD_SNAP} &>>${LOG_PATH}

log_this "Moving new snapshot to ${SNAP_PATH}"
sudo mv ${HOME}/${CHAIN_ID}*tar ${SNAP_PATH} &>>${LOG_PATH}


du -hs ${SNAP_PATH} | sudo tee -a ${LOG_PATH}

log_this "Done\n---------------------------\n"
