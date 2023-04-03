#Sisteminizde olan sdk versiyonunu öğrenerek(dotnet --version) aşağıdaki versiyon ile değiştirin 
FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
# Çalışma klasörünü belirt
WORKDIR /dotnetornek
#csproj projesini kopyala ve ayrı ayrı katmanlara böl
COPY *.csproj ./
RUN dotnet restore
# Diğer herşeyi kopyala ve oluştur.
COPY . ./
RUN dotnet publish -c Release -o out
# Çalışma zamanı imajını oluştur. Sisteminizdeki aspnet versiyonu ile değiştirin.
# Bu dosyanın yazımı sırasında version 3.1 idi.
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
WORKDIR /dotnetornek
COPY --from=build /dotnetornek/out .
# dll dosyasının adı projenizin adı
ENTRYPOINT ["dotnet", "dotnetornek.dll"]