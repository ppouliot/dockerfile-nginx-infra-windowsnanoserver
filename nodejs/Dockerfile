FROM microsoft/nanoserver
LABEL maintainer="peter@pouliot.net"
ENV NODEJS_VERSION 9.9.0

SHELL ["powershell", "-NoProfile", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue'; "]
COPY Dockerfile /Dockerfile
# Install NodeJS
ADD https://nodejs.org/dist/latest-v9.x/node-v$NODEJS_VERSION-win-x64.zip C:\\node-v$NODEJS_VERSION-win-x64.zip
RUN \
    Expand-Archive -Path C:\\node-v$ENV:NODEJS_VERSION-win-x64.zip -DestinationPath C:\\ -Force; \
    Remove-Item -Path c:\\node-v$ENV:NODEJS_VERSION-win-x64.zip -Confirm:$False; \
    Rename-Item -Path node-v$ENV:NODEJS_VERSION-win-x64 -NewName nodejs;
	
# PATH isn't actually set in the Docker image, so we have to set it from within the container
RUN $newPath = ('C:\nodejs;{0}' -f $env:PATH); \
	Write-Host ('Updating PATH: {0}' -f $newPath); \
# Nano Server does not have "[Environment]::SetEnvironmentVariable()"
	setx /M PATH $newPath;
WORKDIR /nodejs
