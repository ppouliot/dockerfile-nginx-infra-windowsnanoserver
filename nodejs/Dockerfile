FROM microsoft/nanoserver
LABEL maintainer="peter@pouliot.net"
ENV NODEJS_VERSION 9.7.1

SHELL ["powershell", "-NoProfile", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue'; "]

# Install NodeJS
ADD https://nodejs.org/dist/latest-v9.x/node-v$NODEJS_VERSION-win-x64.zip C:\\node-v$NODEJS_VERSION-win-x64.zip
RUN \
    Expand-Archive -Path C:\\node-v$ENV:NODEJS_VERSION-win-x64.zip -DestinationPath C:\\ -Force; \
    Remove-Item -Path c:\\node-v$ENV:NODEJS_VERSION-win-x64.zip -Confirm:$False; \
    Rename-Item -Path node-v$ENV:NODEJS_VERSION-win-x64 -NewName nodejs;

WORKDIR /nodejs
