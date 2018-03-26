FROM microsoft/nanoserver
LABEL maintainer="peter@pouliot.net"
ENV PYTHON_VERSION 3.6.4
ENV PYTHON_PIP_VERSION 9.0.3
COPY Dockerfile /Dockerfile

SHELL ["powershell", "-NoProfile", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue'; "]

# Install Python
ADD https://www.python.org/ftp/python/$PYTHON_VERSION/python-$PYTHON_VERSION-embed-amd64.zip c:\\python-$PYTHON_VERSION-embed-amd64.zip
RUN \
    Expand-Archive -Path C:\\python-$ENV:PYTHON_VERSION-embed-amd64.zip -DestinationPath C:\\python -Force; \
    Setx path \"%path%;C:\Python;C:\Python\Scripts\"; \
    Remove-Item -Path c:\\python-$ENV:PYTHON_VERSION-embed-amd64.zip -Confirm:$False; \
    c:\python\python.exe --version ;

# Install Pip
ADD https://bootstrap.pypa.io/get-pip.py C:\\get-pip.py
RUN \
    $env:PATH = 'C:\Python;C:\Python\Scripts;{0}' -f $env:PATH ; \
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\' -Name Path -Value $env:PATH ; \
    mkdir $env:APPDATA\Python\Python36\site-packages ; \
    $replace = ('import tempfile{0}import site{0}site.getusersitepackages()' -f [char][int]10) ; \
    Get-Content get-pip.py | Foreach-Object { $_ -replace 'import tempfile', $replace } | Out-File -Encoding Ascii getpip.py ; \
    $pipInstall = ('pip=={0}' -f $env:PYTHON_PIP_VERSION) ; \
    python getpip.py $pipInstall ; \
    Remove-Item get-pip.py ; \
    Remove-Item getpip.py

WORKDIR /python
ENTRYPOINT C:/python/python.exe
