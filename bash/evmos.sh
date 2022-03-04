#!/bin/bash
CHAIN_ID="evmos_9001-1"
SNAP_PATH="$HOME/nginx/cosmos-snapshots/evmos/"
LOG_PATH="$HOME/nginx/cosmos-snapshots/evmos/evmos_9001-1_log.txt"
DATA_PATH="$HOME/.evmosd/data/"
SERVICE_NAME="evmosd.service"
RPC_ADDRESS="http://127.0.0.1:26797"
SNAP_NAME=$(echo "${CHAIN_ID}_$(date '+%Y-%m-%d').tar")
OLD_SNAP=$(ls ${SNAP_PATH} | egrep -o "${CHAIN_ID}.*tar")

now_date() {
    echo -n $(date +%F-%H-%M-%S)
}

log_this() {
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
time sudo tar cf ${HOME}/${SNAP_NAME} -C ${DATA_PATH} . &>>${LOG_PATH}

log_this "Starting ${SERVICE_NAME}"
sudo systemctl start ${SERVICE_NAME}; echo $? >> ${LOG_PATH}

log_this "Removing old snapshot(s):"
cd ${SNAP_PATH}
sudo rm -fv ${OLD_SNAP} &>>${LOG_PATH}

log_this "Moving new snapshot to ${SNAP_PATH}"
sudo mv ${HOME}/${CHAIN_ID}*tar ${SNAP_PATH} &>>${LOG_PATH}

du -sh ${SNAP_PATH}${SNAP_NAME}| sudo tee -a ${LOG_PATH}

log_this "Done\n---------------------------\n"
