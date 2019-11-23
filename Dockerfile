FROM ubuntu:18.04
LABEL maintainer="chevylin0802@gmail.com"

RUN dpkg --add-architecture i386
RUN apt-get update

# Download specific Android Studio bundle (all packages).
RUN apt-get install -y curl tar 
RUN apt-get install --reinstall tzdata

RUN echo "Asia/Taipei" > /etc/timezone

RUN curl 'https://dl.google.com/dl/android/studio/ide-zips/3.5.2.0/android-studio-ide-191.5977832-linux.tar.gz?hl=zh-cn' > /tmp/studio.tar.gz && tar -zxvf /tmp/studio.tar.gz --directory=/opt && rm /tmp/studio.tar.gz

# Install X11
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y xorg


# Install other useful tools
RUN apt-get install -y nano ant pulseaudio

# install Java
RUN apt-get install -y openjdk-8-jdk

# Install prerequisites
RUN apt-get install -y libz1 libncurses5 libbz2-1.0:i386 libstdc++6 libbz2-1.0 lib32stdc++6 lib32z1 git


# Clean up
RUN apt-get clean
RUN apt-get purge

RUN groupadd -g 1000 puser
RUN useradd -g 1000 -u 1000 puser
RUN mkdir /home/puser
RUN chown -R puser:puser /home/puser

USER puser

