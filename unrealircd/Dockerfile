FROM microsoft/windowsservercore
LABEL maintainer="peter@pouliot.net"
ENV UNREALIRCD_VERSION 4.0.17

SHELL ["powershell"]
# Note: Install Chocolatey
RUN \
    # Install Chocolatey
    Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
RUN \
    # Install Choco Package
    choco install openssh vcredist2012 -Y ; \
    refreshenv ;
ADD https://www.unrealircd.org/unrealircd4/unrealircd-$UNREALIRCD_VERSION.exe C:/unrealircd-$UNREALIRCD_VERSION.exe
RUN \
    Expand-Archive -Path C:\\unrealircd-$ENV:UNREALIRCD_VERSION.exe -DestinationPath C:\\unrealircd -Force; 
	# C:\\unrealircd-$ENV:UNREALIRCD_VERSION.exe /LANG=default /GROUP=UnrealIRCd /SP- /SUPRESSMSGBOXES /VERYSILENT /NOICONS=0 /TASKS=installservice,installservice\startboot,installservice\crashrestart,makecert,fixperm

