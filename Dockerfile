FROM cm2network/steamcmd

# Valheim installation path
ENV VALHEIM_SERVER_DIR "/home/steam/valheim-server"

# Install the Valheim server
RUN ./steamcmd.sh \
+force_install_dir $VALHEIM_SERVER_DIR \
+login anonymous \
+app_update 896660 validate \
+exit

# World data save folder, map this to the host directory where your worlds are stored
# e.g. docker run -v /path/to/host/directory:/home/steam/valheim-data
ENV VALHEIM_DATA_DIR "/home/steam/valheim-data"
# Valheim port (default is 2456)
ENV VALHEIM_PORT 2456
# Server and world name are truncated after 1st white space
# you must set values to the server and world name otherwise the container will exit immediately
ENV VALHEIM_SERVER_NAME=""
ENV VALHEIM_WORLD_NAME=""
ENV VALHEIM_PASSWORD "password"
ENV VALHEIM_PUBLIC 1

# Expose ports needed byt server (default UPD:2456-2458)
EXPOSE 2456-2458/udp

VOLUME ${VALHEIM_DATA_DIR}

# Copy over the modified server start script
COPY start-valleballe-server.sh ${VALHEIM_SERVER_DIR}
# RUN chmod +x ${VALHEIM_SERVER_DIR}/start-valleballe-server.sh
WORKDIR ${VALHEIM_SERVER_DIR}

# Start server
ENTRYPOINT ["./start-valleballe-server.sh"]