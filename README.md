# PixARK Server

This Dockerfile is designed to set up a PixARK dedicated server in a Docker container on TrueNAS Scale primarily.

## Setting Environment Variables

You can customize your PixARK server by setting the appropriate environment variables. Here are the variables available:

- **SERVER_NAME**: Server name to display in the server browser (default: `PixarkContainer`).
- **WORLD_DIR**: Directory name for the world (default: `world`).
- **WORLD_TYPE**: Defines the world type (default: `CubeWorld_Light`).
- **SEED**: Seed for map generation (default: `12345`).
- **MAX_PLAYERS**: Max number of players (default: `20`).
- **STEAM_PORT**: Steam port (default: `27015`).
- **QUERY_PORT**: Query port (default: `27016`).
- **RCON_PORT**: RCON port (default: `27017`).
- **CUBE_PORT**: Cube port (default: `27018`).
- **DELAY_REG_SERVER**: Delay server registration (default: `True`).
- **RAW_SOCKETS**: Use raw sockets (default: `True`).
- **SERVER_ADMIN_PASSWORD**: Admin password (default: `letmein`).
- **RCON_ENABLED**: Enable RCON (default: `True`).
- **CULTURE_FOR_COOKING**: Language culture for cooking (default: `en`).
- **LOG**: Enable logging (default: `True`).
- **GAMEPLAY_LOGGING**: Enable gameplay logging (default: `True`).
- **NO_BATTLEYE**: Disable BattleEye (default: `True`).
- **USE_ALT_DIR**: Use alternative directory (default: `False`).
- **ALT_SAVE_DIR**: (Optional) Alternative save directory.
- **SERVER_PASSWORD**: (Optional) Server password.
- **ADDITIONAL_ARGS**: (Optional) Additional arguments.

## Port forwarding (TCP and UDP)

> Exposed and forwarded ports must be the same, no remapping.

Make sure to port expose and forward;
- STEAM_PORT
- QUERY_PORT
- RCON_PORT
- CUBE_PORT

## Persistence

Mount the persistence directory to `/persistence`
Make sure the directory on TrueNAS is owned by the user and group `apps`
