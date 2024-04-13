#!/bin/bash

# Log in to Steam anonymously and download the Enshrouded dedicated server app
/opt/steamcmd/steamcmd.sh +force_install_dir /persistence +@sSteamCmdForcePlatformType windows +login anonymous +app_update 2278520 validate +quit

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
CMD_START="wine64 /persistence/enshrouded_server.exe"

# Execute the command
exec $CMD_START
