FROM ppouliot/nginx-windowsnanoserver
LABEL maintainer="peter@pouliot.net"
ENV WIN_ACME_VERSION 1.9.9.0
COPY Dockerfile /Dockerfile
SHELL ["powershell", "-NoProfile", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue'; "]

# Let'sencrypt win-acme
ADD https://github.com/PKISharp/win-acme/releases/download/v$WIN_ACME_VERSION/win-acme.v$WIN_ACME_VERSION.zip C:\\win-acme.v$WIN_ACME_VERSION.zip
RUN \
    Expand-Archive -Path C:\\win-acme.v$ENV:WIN_ACME_VERSION.zip -DestinationPath C:\\win-acme -Force; \
    Remove-Item -Path C:\\win-acme.v$ENV:WIN_ACME_VERSION.zip -Confirm:$False; \
    mkdir -p C:\\nginx\\.well-known\\acme-challenge
#   Rename-Item -Path C:\\win-acme.v$ENV:WIN_ACME_VERSION -NewName win-acme

WORKDIR /nginx
EXPOSE 80
CMD ["nginx", "-g", "\"daemon off;\""]


