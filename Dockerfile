FROM ubuntu:18.04

#----------------------------------------------------------------------------
# Base Develop Environment
#----------------------------------------------------------------------------
ARG PKGS="vim zsh tmux git curl wget unzip net-tools python3 tig htop ncdu dstat gcc g++"
ARG MORE_PKGS="libopencv-dev"
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ Asia/Shanghai
RUN apt update && apt install -y ${PKGS} ${MORE_PKGS}
RUN mkdir -p /root/git; cd /root/git; \
    git clone https://github.com/tworuler/my-linux-config.git; \
    cd my-linux-config; bash install.sh

#----------------------------------------------------------------------------
# Android Environment
#----------------------------------------------------------------------------
ARG ANDROID_DEV_HOME=/android
RUN mkdir -p ${ANDROID_DEV_HOME}

RUN apt-get install -y --no-install-recommends default-jdk

# Install Android SDK.
# get latest sdk tools: https://developer.android.com/studio/#downloads
ARG ANDROID_SDK_FILENAME=commandlinetools-linux-8512546_latest.zip
ARG ANDROID_SDK_URL=https://dl.google.com/android/repository/${ANDROID_SDK_FILENAME}
ENV ANDROID_SDK_HOME ${ANDROID_DEV_HOME}/sdk
ENV ANDROID_API_LEVEL 23
ENV ANDROID_NDK_API_LEVEL 21
ENV ANDROID_BUILD_TOOLS_VERSION 30.0.0
RUN mkdir -p ${ANDROID_SDK_HOME}/cmdline-tools
ENV PATH ${PATH}:${ANDROID_SDK_HOME}/cmdline-tools/latest/bin:${ANDROID_SDK_HOME}/platform-tools
RUN cd ${ANDROID_DEV_HOME} && \
    wget ${ANDROID_SDK_URL} && \
    unzip ${ANDROID_SDK_FILENAME} -d /tmp && \
    mv /tmp/cmdline-tools ${ANDROID_SDK_HOME}/cmdline-tools/latest && \
    rm ${ANDROID_SDK_FILENAME} && \
    yes | sdkmanager \
      "build-tools;${ANDROID_BUILD_TOOLS_VERSION}" \
      "platform-tools" \
      "platforms;android-${ANDROID_API_LEVEL}"

# get latest ndk: https://developer.android.com/ndk/downloads/revision_history
ARG ANDROID_NDK_FILENAME=android-ndk-r19c-linux-x86_64.zip
ARG ANDROID_NDK_URL=https://dl.google.com/android/repository/${ANDROID_NDK_FILENAME}
ENV ANDROID_NDK_HOME ${ANDROID_DEV_HOME}/ndk
ENV PATH ${PATH}:${ANDROID_NDK_HOME}
RUN cd ${ANDROID_DEV_HOME} && \
    wget ${ANDROID_NDK_URL} && \
    unzip ${ANDROID_NDK_FILENAME} -d ${ANDROID_DEV_HOME} && \
    rm ${ANDROID_NDK_FILENAME} && \
    bash -c "ln -s ${ANDROID_DEV_HOME}/android-ndk-* ${ANDROID_NDK_HOME}"
