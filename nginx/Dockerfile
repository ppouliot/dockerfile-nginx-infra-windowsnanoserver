FROM microsoft/nanoserver
LABEL maintainer="peter@pouliot.net"
ENV NGINX_VERSION 1.13.10-dev

SHELL ["powershell", "-NoProfile", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue'; "]

# Install Nginx

ADD https://www.nginx.kr/nginx/win64/nginx-$NGINX_VERSION-win64.zip c:\\nginx-$NGINX_VERSION-win64.zip
RUN \
    Expand-Archive -Path C:\\nginx-$ENV:NGINX_VERSION-win64.zip -DestinationPath C:\\ -Force ; \
    Remove-Item -Path c:\\nginx-$ENV:NGINX_VERSION-win64.zip -Confirm:$False; \
    Rename-Item -Path C:\\nginx-$ENV:NGINX_VERSION-win64 -NewName nginx;

RUN \
    # Make sure that Docker always uses default DNS servers which hosted by Dockerd.exe
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name ServerPriorityTimeLimit -Value 0 -Type DWord; \
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name ScreenDefaultServers -Value 0 -Type DWord; \
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name ScreenUnreachableServers -Value 0 -Type DWord; \
    # Shorten DNS cache times
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name MaxCacheTtl -Value 30 -Type DWord; \
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name MaxNegativeCacheTtl -Value 30 -Type DWord

WORKDIR /nginx
EXPOSE 80
CMD ["nginx", "-g", "\"daemon off;\""]
