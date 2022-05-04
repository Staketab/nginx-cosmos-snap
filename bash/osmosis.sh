#!/bin/bash
CHAIN_ID="osmosis-1"
FOLDER="osmosis"
SNAP_PATH="$HOME/nginx/cosmos-snapshots/${FOLDER}/"
LOG_PATH="$HOME/nginx/cosmos-snapshots/${FOLDER}/${CHAIN_ID}_log.txt"
DATA_PATH="$HOME/.osmosisd/data/"
SERVICE_NAME="osmosisd.service"
RPC_ADDRESS="http://127.0.0.1:16957"
SNAP_DATE=$(date '+%Y-%m-%d')
SNAP_NAME=$(echo "${CHAIN_ID}_${SNAP_DATE}.tar")
OLD_SNAP=$(ls ${SNAP_PATH} | egrep -o "${CHAIN_ID}.*tar")
DOMAIN="https://cosmos-snap.staketab.com/${FOLDER}/"
NOW_DATE=$(date +%F-%H-%M-%S)
JSON_DATE=$(date +%D,%T,%Z -u)
WASM_PATH="$HOME/.osmosisd/wasm/"
if [ -e ${WASM_PATH} ]; then
    WASM_SNAP_NAME=$(echo "wasm_${CHAIN_ID}_${SNAP_DATE}.tar")
    OLD_WASM_SNAP=$(ls ${SNAP_PATH} | egrep -o "wasm_${CHAIN_ID}.*tar")
    WASM_LINK="${DOMAIN}${WASM_SNAP_NAME}"
fi

now_date() {
    echo -n ${NOW_DATE}
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

if [ -e ${WASM_PATH} ]; then
  log_this "Creating new wasm snapshot"
  time sudo tar cf ${HOME}/${WASM_SNAP_NAME} -C ${WASM_PATH} . &>>${LOG_PATH}
fi

log_this "Starting ${SERVICE_NAME}"
sudo systemctl start ${SERVICE_NAME}; echo $? >> ${LOG_PATH}

log_this "Removing old snapshot(s):"
cd ${SNAP_PATH}
sudo rm -fv ${OLD_SNAP} &>>${LOG_PATH}

if [ -e ${WASM_PATH} ]; then
    log_this "Removing old wasm snapshot(s):"
    cd ${SNAP_PATH}
    sudo rm -fv ${OLD_WASM_SNAP} &>>${LOG_PATH}
fi

log_this "Moving new snapshot to ${SNAP_PATH}"
sudo mv ${HOME}/${CHAIN_ID}*tar ${SNAP_PATH} &>>${LOG_PATH}

if [ -e ${WASM_PATH} ]; then
    log_this "Moving new wasm snapshot to ${SNAP_PATH}"
    sudo mv ${HOME}/wasm_${CHAIN_ID}_*tar ${SNAP_PATH} &>>${LOG_PATH}
fi

SIZE="$(wc -c ${SNAP_PATH}${SNAP_NAME} | awk '{print $1}')"
log_this "Snapshot size is: ${SIZE}"

if [ -e ${WASM_PATH} ]; then
    WASM_SIZE="$(wc -c ${SNAP_PATH}${WASM_SNAP_NAME} | awk '{print $1}')"
    log_this "Wasm snapshot size is: ${WASM_SIZE}"
fi
#du -sh  ${SNAP_PATH}${SNAP_NAME} | sudo tee -a ${LOG_PATH}

log_this "Done\n---------------------------\n"

echo "{
    \"last_height\": \"${LAST_BLOCK_HEIGHT}\",
    \"date\": \"${JSON_DATE}\",
    \"snap_filename\": \"${SNAP_NAME}\",
    \"snap_link\": \"${DOMAIN}${SNAP_NAME}\",
    \"snap_size\": \"${SIZE}\",
    \"wasm_filename\": \"${WASM_SNAP_NAME}\",
    \"wasm_link\": \"${WASM_LINK}\",
    \"wasm_size\": \"${WASM_SIZE}\"
}" >${SNAP_PATH}state.json
