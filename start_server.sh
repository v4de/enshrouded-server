#!/bin/bash

# Set shell vars
install_dir="/persistence"
app="2278520"
config="$install_dir/enshrouded_server.json"
config_tmp="$install_dir/enshrouded_server_temp.json"

# Log in to Steam anonymously and download the Enshrouded dedicated server app
echo "Updating Enshrouded Dedicated Server"
/opt/steamcmd/steamcmd.sh +force_install_dir "$install_dir" +@sSteamCmdForcePlatformType windows +login anonymous +app_update ${app} validate +quit

# Log config vars
echo "Logging config values:"
echo "SAVE_DIRECTORY: ${SAVE_DIRECTORY}"
echo "LOG_DIRECTORY: ${LOG_DIRECTORY}"
echo "IP: ${IP}"
echo "GAME_PORT: ${GAME_PORT}"
echo "QUERY_PORT: ${QUERY_PORT}"
echo "SLOT_COUNT: ${SLOT_COUNT}"
echo "NAME: ${NAME}"

# Never log passwords
if [ -z "${PASSWORD}" ]; then
    echo "PASSWORD not set"
else
    echo "PASSWORD set"
fi

# Set the configuration file
if [ ! -f "$config" ]; then
    jq -n --arg name "$NAME" \
        --arg password "$PASSWORD" \
        --arg saveDir "$SAVE_DIRECTORY" \
        --arg logDir "$LOG_DIRECTORY" \
        --arg ip "$IP" \
        --argjson gamePort "$GAME_PORT" \
        --argjson queryPort "$QUERY_PORT" \
        --argjson slotCount "$SLOT_COUNT" \
        '{name: $name, password: $password, saveDirectory: $saveDir, logDirectory: $logDir, ip: $ip, gamePort: $gamePort, queryPort: $queryPort, slotCount: $slotCount}' > $config
else
    jq --arg name "$NAME" '.name = $name' $config | \
    jq --arg password "$PASSWORD" '.password = $password' | \
    jq --arg saveDir "$SAVE_DIRECTORY" '.saveDirectory = $saveDir' | \
    jq --arg logDir "$LOG_DIRECTORY" '.logDirectory = $logDir' | \
    jq --arg ip "$IP" '.ip = $ip' | \
    jq --argjson gamePort "$GAME_PORT" '.gamePort = $gamePort' | \
    jq --argjson queryPort "$QUERY_PORT" '.queryPort = $queryPort' | \
    jq --argjson slotCount "$SLOT_COUNT" '.slotCount = $slotCount' \
    > $config_tmp && \
    rm $config && \
    mv $config_tmp $config
fi

# Start command, preparing for command building
CMD_START="wine64 $install_dir/enshrouded_server.exe"

# Execute the command
exec $CMD_START
