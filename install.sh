#!/usr/bin/env sh

PROJECT="paper"
MINECRAFT_VERSION="1.21.3"

LATEST_BUILD=$(curl -s https://api.papermc.io/v2/projects/${PROJECT}/versions/${MINECRAFT_VERSION}/builds | \
    jq -r '.builds | map(select(.channel == "default") | .build) | .[-1]')

if [ "$LATEST_BUILD" != "null" ]; then
    JAR_NAME=${PROJECT}-${MINECRAFT_VERSION}-${LATEST_BUILD}.jar
    PAPERMC_URL="https://api.papermc.io/v2/projects/${PROJECT}/versions/${MINECRAFT_VERSION}/builds/${LATEST_BUILD}/downloads/${JAR_NAME}"

    curl -o paperclip.jar $PAPERMC_URL
    echo "Download completed"
else
    echo "No stable build for version $MINECRAFT_VERSION found :("
fi

mkdir plugins
curl -o ./plugins/viaversion.jar https://hangarcdn.papermc.io/plugins/ViaVersion/ViaVersion/versions/5.4.1/PAPER/ViaVersion-5.4.1.jar

PROJECT="floodgate"
VERSION="2.2.4"

LATEST_BUILD=$(curl -s https://download.geysermc.org/v2/projects/${PROJECT}/versions/${VERSION}/builds | \
    jq -r '.builds | map(select(.channel == "default") | .build) | .[-1]')

if [ "$LATEST_BUILD" != "null" ]; then
    FILE_NAME=spigot
    DOWNLOAD_URL="https://download.geysermc.org/v2/projects/${PROJECT}/versions/${VERSION}/builds/${LATEST_BUILD}/downloads/${FILE_NAME}"

    curl -o ./plugins/floodgate.jar $DOWNLOAD_URL
    echo "Download completed $DOWNLOAD_URL"
else
    echo "No stable build for version $VERSION found :("
fi
