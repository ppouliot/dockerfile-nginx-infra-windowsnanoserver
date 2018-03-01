FROM microsoft/nanoserver
LABEL maintainer="peter@pouliot.net"
ENV NGINX_VERSION 1.13.8-dev
ENV PYTHON_VERSION 3.7.0
ENV NODEJS_VERSION 9.6.1
ENV WIN_ACME_VERSION 1.9.9.0
SHELL ["powershell", "-command"]
RUN \
    # Install NodeJS
    Invoke-WebRequest -Uri https://nodejs.org/dist/latest-v9.x/node-v$ENV:NODEJS_VERSION-win-x64.zip -Outfile c:\node-v$ENV:NODEJS_VERSION-win-x64.zip; \
    Expand-Archive -Path C:\node-v$ENV:NODEJS_VERSION-win-x64.zip -DestinationPath C:\ -Force; \
    Remove-Item -Path c:\node-v$ENV:NODEJS_VERSION-win-x64.zip -Confirm:$False; \
    Rename-Item -Path node-v$ENV:NODEJS_VERSION-win-x64 -NewName nodejs; \
    refreshenv;
RUN \
    # Install Python
    Invoke-WebRequest -Uri https://www.python.org/ftp/python/$ENV:PYTHON_VERSION/python-$ENV:PYTHON_VERSION-embed-amd64.zip -OutFile c:\python-$ENV:PYTHON_VERSION-embed-amd64.zip; \
    Expand-Archive -Path C:\python-$ENV:PYTHON_VERSION-embed-amd64.zip -DestinationPath C:\ -Force; \
    Remove-Item -Path c:\python-$ENV:PYTHON_VERSION-embed-amd64.zip -Confirm:$False; \
    Rename-Item -Path python-$ENV:PYTHON_VERSION-embed-amd64 -NewName Python; \
    refreshenv;
RUN \
    # Install Nginx
    Invoke-WebRequest -Uri https://www.nginx.kr/nginx/win64/nginx-$ENV:NGINX_VERSION-win64.zip -OutFile c:\nginx-$ENV:NGINX_VERSION-win64.zip; \
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
RUN \
    # Let'sencrypt win-acme
    Invoke-WebRequest -Uri https://github.com/PKISharp/win-acme/releases/download/v$ENV:WIN_ACME_VERSION/win-acme.v$ENV:WIN_ACME_VERSION.zip -OutFile win-acme.v$ENV:WIN_ACME_VERSION.zip \
    Expand-Archive -Path C:\win-acme.v$ENV:NGINX_VERSION.zip -DestinationPath C:\ -Force; \
    Remove-Item -Path C:\win-acme.v$ENV:NGINX_VERSION.zip -Confirm:$False \
    Rename-Item -Path C:\win-acme.v$ENV:NGINX_VERSION -NewName win-acme

WORKDIR /nginx
EXPOSE 80
CMD ["nginx", "-g", "\"daemon off;\""]
