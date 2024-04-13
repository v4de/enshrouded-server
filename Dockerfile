FROM archlinux:latest

# Copy the startup script to the container
COPY start_server.sh /start_server.sh

RUN echo -e "\n[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf && \
    pacman -Syu --noconfirm && \
    pacman -S jq wget wine winetricks lib32-libunwind --noconfirm && \
    wget http://media.steampowered.com/installer/steamcmd_linux.tar.gz && \
    mkdir -p /opt/steamcmd && \
    tar -xvzf steamcmd_linux.tar.gz -C /opt/steamcmd && \
    rm steamcmd_linux.tar.gz && \
    groupadd -g 568 apps && \
    useradd -u 568 -g 568 apps && \
    mkdir -p /home/apps && \
    mkdir -p /persistence && \
    chmod +x /start_server.sh && \
    chmod +x /opt/steamcmd/linux32/steamcmd && \
    chmod +x /opt/steamcmd/steamcmd.sh && \
    chown -R apps:apps /home/apps && \
    chown -R apps:apps /opt/steamcmd && \
    chown -R apps:apps /persistence

# Set environment variables with default values
ENV NAME=Server
ENV PASSWORD=
ENV SAVE_DIRECTORY=/persistence/savegame
ENV LOG_DIRECTORY=/persistence/logs
ENV IP=0.0.0.0
ENV GAME_PORT=15636
ENV QUERY_PORT=15637
ENV SLOT_COUNT=16

# Switch to 'apps' user for the container runtime
USER apps

# Wine configuration
ENV WINEDEBUG=-all
ENV WINEPREFIX=/persistence/.wine

# Prepare wine
RUN wineboot --init

# Use the startup script as the command
CMD ["/start_server.sh"]
