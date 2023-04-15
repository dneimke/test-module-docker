FROM mcr.microsoft.com/powershell:latest

COPY build/TestableModule ./opt/microsoft/powershell/7/Modules

COPY Consumers /ps-consumers/

# Create a path in advance, then add required commands to the file
RUN mkdir -p /root/.config/powershell/
RUN echo "Import-Module TestableModule" > /root/.config/powershell/Microsoft.PowerShell_profile.ps1

ENTRYPOINT ["pwsh"]