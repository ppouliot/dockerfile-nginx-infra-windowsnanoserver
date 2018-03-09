FROM microsoft/nanoserver
LABEL maintainer="peter@pouliot.net"
ENV PYTHON_VERSION 3.6.4

SHELL ["powershell", "-NoProfile", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue'; "]

# Install Python
ADD https://www.python.org/ftp/python/$PYTHON_VERSION/python-$PYTHON_VERSION-embed-amd64.zip c:\\python-$PYTHON_VERSION-embed-amd64.zip
ADD https://bootstrap.pypa.io/get-pip.py C:\get-pip.py
RUN \
    Expand-Archive -Path C:\\python-$ENV:PYTHON_VERSION-embed-amd64.zip -DestinationPath C:\\python -Force; \
    Setx path \"%path%;C:\Python;C:\Python\Scripts\"; \
    Remove-Item -Path c:\\python-$ENV:PYTHON_VERSION-embed-amd64.zip -Confirm:$False; \
    c:\python\python.exe --version
#	Remove-Item -Path c:\get-pip.py -Confirm:$False;

WORKDIR /python
ENTRYPOINT C:/python/python.exe
