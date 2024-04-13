# Enshrouded Server

This Dockerfile is designed to set up a Enshrouded dedicated server in a Docker container on TrueNAS Scale primarily.

## Setting Environment Variables

You can customize your Enshrouded server by setting the appropriate environment variables. Here are the variables available:

- **NAME**: Server name to display in the server browser (default: `Server`).
- **PASSWORD**: Server password, blank is no password (default: ` `).
- **SAVE_DIRECTORY**: The save game directory (default: `./savegame`).
- **LOG_DIRECTORY**: The logging directory (default: `./logs`).
- **IP**: The IP address to bind to (default: `0.0.0.0`).
- **GAME_PORT**: Game port (default: `15636`).
- **QUERY_PORT**: Query port must be +1 to the GAME_PORT (default: `15637`).
- **SLOT_COUNT**: Max number of players (default: `16`).

## Port forwarding (TCP and UDP)

> Exposed and forwarded ports must be the same, no remapping.

Make sure to port expose and forward;
- GAME_PORT
- QUERY_PORT

## Persistence

Mount the persistence directory to `/persistence`

Make sure the directory on TrueNAS is owned by the user and group `apps`
