FROM --platform=$BUILDPLATFORM debian AS build

WORKDIR /paper

COPY ./server.properties /paper/server.properties
COPY ./bukkit.yml /paper/bukkit.yml
COPY ./spigot.yml /paper/spigot.yml

COPY install.sh /paper/installer.sh

RUN apt-get update
RUN apt-get install jq curl -y
RUN chmod +x ./installer.sh && ./installer.sh
RUN rm ./installer.sh -rf


FROM --platform=$BUILDPLATFORM ghcr.io/graalvm/graalvm-community AS RUN

WORKDIR /paper

COPY --from=BUILD /paper/ /paper

EXPOSE 25565

CMD ["java", "-Xmx2G", "-Xms2G", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseJVMCICompiler", "-Dcom.mojang.eula.agree=true", "-jar", "paperclip.jar", "--nogui"]