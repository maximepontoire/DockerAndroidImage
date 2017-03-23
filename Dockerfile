FROM ubuntu:14.04

MAINTAINER Maxime PONTOIRE <mpontoire.prestataire@voyages-sncf.com>

RUN apt-get update -qq

# Install Java8
RUN apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:webupd8team/java && \
    apt-get update && \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y oracle-java8-installer

# Install Deps
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y --force-yes expect git wget libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 lib32z1 python curl && \
    apt-get clean

# Install unzip
RUN apt-get install -y unzip

# Install Android SDK
ENV ANDROID_SDK_VERSION=r25.2.3 \
ANDROID_BUILD_TOOLS_VERSION=25.2.3 \
ANDROID_API_LEVELS=android-25


RUN wget --output-document=tools.zip --quiet http://dl.google.com/android/repository/tools_${ANDROID_SDK_VERSION}-linux.zip && \
    unzip tools.zip && \
    mkdir -p /usr/local/android-sdk && \
    mv tools /usr/local/android-sdk/tools && \
    rm -f tools.zip && \
    chown -R root.root /usr/local/android-sdk && \
    chmod +777 /usr/local/android-sdk && \
    chmod +777 /usr/local/android-sdk/tools

# Install Gradle
RUN wget https://services.gradle.org/distributions/gradle-2.14.1-all.zip && \
    unzip gradle-2.14.1-all.zip && \
    mv gradle-2.14.1 /usr/local/ && \
    mv gradle-2.14.1-all.zip /usr/local/

# Environment variables
ENV ANDROID_SDK_HOME /usr/local/android-sdk
ENV ANDROID_HOME $ANDROID_SDK_HOME
ENV GRADLE_HOME /usr/local/gradle-2.14.1
ENV PATH $PATH:$ANDROID_SDK_HOME/tools/bin
ENV PATH $PATH:$ANDROID_SDK_HOME/tools
ENV PATH $PATH:$ANDROID_SDK_HOME/platform-tools
ENV PATH $PATH:$GRADLE_HOME/bin
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

RUN echo y | $ANDROID_HOME/tools/bin/sdkmanager "tools" "platform-tools" "platforms;android-25" "build-tools;25.0.2" "extras;android;m2repository" "extras;google;m2repository"

# Git to pull external repositories of Android app projects
RUN apt-get install -y --no-install-recommends git

# Cleaning
RUN apt-get clean

# WorkDir
RUN mkdir -p $ANDROID_HOME/.android && \
    keytool -genkey -v -keystore $ANDROID_HOME//.android/debug.keystore -storepass android -alias androiddebugkey -keypass android -dname "CN=Android Debug,O=Android,C=US"

# TODO : DEFINE WORKDIR $ANDROID_HOME/.android
