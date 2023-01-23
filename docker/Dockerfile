# Pull base image.
FROM jlesage/baseimage-gui:debian-10-v4

# Set the name of the application.
ENV APP_NAME="StardewValley"

RUN apt-get update
RUN apt-get install -y wget unzip tar strace mono-complete xterm gettext-base jq netcat procps 
RUN APP_ICON_URL=https://stardewcommunitywiki.com/mediawiki/images/4/48/Fiddlehead_Fern.png && \
    install_app_icon.sh "$APP_ICON_URL"

# Game + ModLoader 1.5.6 3.14.7
RUN mkdir -p /data/Stardew && \
    mkdir -p /data/nexus && \
    wget https://rhino.eu.org/Stardew_legacy.tar.gz -qO /data/latest.tar.gz && \
    tar xf /data/latest.tar.gz -C /data/Stardew && \
    rm /data/latest.tar.gz 

RUN wget -qO dotnet.tar.gz https://download.visualstudio.microsoft.com/download/pr/27840e8b-d61c-472d-8e11-c16784d40091/ae9780ccda4499405cf6f0924f6f036a/dotnet-sdk-5.0.100-linux-arm64.tar.gz \
#RUN wget -qO dotnet.tar.gz https://download.visualstudio.microsoft.com/download/pr/95352809-7f41-40f3-974d-8d530321a8e4/0024d7bf0c872f176ceba7a63a34915b/dotnet-runtime-6.0.0-linux-musl-x64.tar.gz \
    && tar -zxf dotnet.tar.gz -C /usr/share/dotnet \
    && rm dotnet.tar.gz \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet 

RUN wget https://github.com/Pathoschild/SMAPI/releases/download/3.14.7/SMAPI-3.14.7-installer.zip -qO /data/nexus.zip && \
    unzip /data/nexus.zip -d /data/nexus/ && \
    /bin/bash -c "SMAPI_NO_TERMINAL=true SMAPI_USE_CURRENT_SHELL=true echo -e \"2\n\n\" | /data/nexus/SMAPI\ 3.14.7\ installer/internal/linux/SMAPI.Installer --install --game-path \"/data/Stardew/Stardew Valley\"" || :


# Add Mods & Scripts
COPY scripts/ /opt/

RUN chmod +x /data/Stardew/Stardew\ Valley/StardewValley && \
    chmod -R 777 /data/Stardew/ && \
    chown -R 1000:1000 /data/Stardew && \
    chmod +x /opt/*.sh

COPY docker-entrypoint.sh /startapp.sh
