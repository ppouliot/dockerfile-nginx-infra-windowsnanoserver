FROM ppouliot/python-windowsnanoserver
LABEL maintainer="peter@pouliot.net"
COPY Dockerfile /Dockerfile

SHELL ["powershell", "-NoProfile", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue'; "]
RUN \
    pip install bumpversion; \
    refreshenv ;