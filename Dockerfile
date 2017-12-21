FROM jenkins/jenkins:2.60.3
MAINTAINER Jun Chen<jchen@nlis.com.au>

USER root

RUN sh -c "echo 'deb [arch=amd64] http://apt-mo.trafficmanager.net/repos/dotnet-release/ xenial main' > /etc/apt/sources.list.d/dotnetdev.list"
RUN sh -c "apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 417A0893"
RUN apt-get update
RUN apt-get install -y dotnet-dev-1.0.3

# Trigger the population of the local package cache
ENV NUGET_XMLDOC_MODE skip
RUN mkdir warmup \
    && cd warmup \
    && dotnet new \
    && cd .. \
    && rm -rf warmup \
    && rm -rf /tmp/NuGetScratch
USER jenkins
