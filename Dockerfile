FROM microsoft/nanoserver
LABEL maintainer="peter@pouliot.net"
ENV NGINX_VERSION 1.13.8-dev
ENV PYTHON_VERSION 3.6.4
ENV NODEJS_VERSION 9.7.0
ENV WIN_ACME_VERSION 1.9.9.0

SHELL ["powershell", "-NoProfile", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue'; "]

# Install NodeJS
ADD https://nodejs.org/dist/latest-v9.x/node-v$NODEJS_VERSION-win-x64.zip C:\node-v$NODEJS_VERSION-win-x64.zip
RUN \
    Expand-Archive -Path C:\node-v$ENV:NODEJS_VERSION-win-x64.zip -DestinationPath C:\ -Force; \
    Remove-Item -Path c:\node-v$ENV:NODEJS_VERSION-win-x64.zip -Confirm:$False; \
    Rename-Item -Path node-v$ENV:NODEJS_VERSION-win-x64 -NewName nodejs;

# Install Python
ADD https://www.python.org/ftp/python/$PYTHON_VERSION/python-$PYTHON_VERSION-embed-amd64.zip c:\python-$PYTHON_VERSION-embed-amd64.zip
ADD https://bootstrap.pypa.io/get-pip.py C:\get-pip.py
RUN \
    Expand-Archive -Path C:\python-$ENV:PYTHON_VERSION-embed-amd64.zip -DestinationPath C:\python -Force; #\
#    Remove-Item -Path c:\python-$ENV:PYTHON_VERSION-embed-amd64.zip -Confirm:$False; \
#    Rename-Item -Path python-$ENV:PYTHON_VERSION-embed-amd64 -NewName Python; \
#    C:\python\python3.exe C:\get-pip.py \
#	Remove-Item -Path c:\get-pip.py -Confirm:$False;

# Install Nginx
ADD https://www.nginx.kr/nginx/win64/nginx-$NGINX_VERSION-win64.zip c:\nginx-$NGINX_VERSION-win64.zip
RUN \
    Expand-Archive -Path C:\nginx-$ENV:NGINX_VERSION-win64.zip -DestinationPath C:\ -Force; \
    Remove-Item -Path c:\nginx-$ENV:NGINX_VERSION-win64.zip -Confirm:$False; \
    Rename-Item -Path nginx-$ENV:NGINX_VERSION-win64 -NewName nginx;
RUN \
    # Make sure that Docker always uses default DNS servers which hosted by Dockerd.exe
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name ServerPriorityTimeLimit -Value 0 -Type DWord; \
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name ScreenDefaultServers -Value 0 -Type DWord; \
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name ScreenUnreachableServers -Value 0 -Type DWord; \
    # Shorten DNS cache times
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name MaxCacheTtl -Value 30 -Type DWord; \
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name MaxNegativeCacheTtl -Value 30 -Type DWord

# Let'sencrypt win-acme
ADD https://github.com/PKISharp/win-acme/releases/download/v$WIN_ACME_VERSION/win-acme.v$WIN_ACME_VERSION.zip C:\win-acme.v$WIN_ACME_VERSION.zip
RUN \
    Expand-Archive -Path C:\win-acme.v$ENV:WIN_ACME_VERSIONzip -DestinationPath C:\ -Force; \
    Remove-Item -Path C:\win-acme.v$ENV:WIN_ACME_VERSION.zip -Confirm:$False \
    Rename-Item -Path C:\win-acme.v$ENV:WIN_ACME_VERSION -NewName win-acme

WORKDIR /nginx
EXPOSE 80
CMD ["nginx", "-g", "\"daemon off;\""]
