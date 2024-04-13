#!/bin/bash

# Log in to Steam anonymously and download the Enshrouded dedicated server app
/opt/steamcmd/steamcmd.sh +force_install_dir /persistence +@sSteamCmdForcePlatformType windows +login anonymous +app_update 2278520 validate +quit

# Start command, preparing for command building
CMD_START="wine64 /persistence/enshrouded_server.exe"

# Execute the command
exec $CMD_START
