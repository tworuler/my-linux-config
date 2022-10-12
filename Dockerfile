#----------------------------------------------------------------------------
# Base Develop Environment
#----------------------------------------------------------------------------
FROM ubuntu:22.04 AS base-dev

ARG PKGS="vim zsh tmux man git iputils-ping locate file curl wget zip unzip tree rsync net-tools python3 htop ncdu dstat gcc g++"
ARG PKGS2="software-properties-common pip axel tig fd-find ripgrep bat duf neofetch"
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai
ENV LANG=en_US.UTF-8
COPY ubuntu/apt_source_list.sh /tmp/apt_source_list.sh
RUN /tmp/apt_source_list.sh && rm /tmp/apt_source_list.sh
RUN apt update && apt install -y ${PKGS} && \
    ln -s python3 /usr/bin/python
RUN apt install -y ${PKGS2} && \
    ln -s fdfind /usr/bin/fd

ARG PKG_DELTA_VERSION=0.14.0
ARG PKG_DELTA_NAME=git-delta_${PKG_DELTA_VERSION}_amd64.deb
ARG PKG_DELTA_URL=https://github.com/dandavison/delta/releases/download/0.14.0/${PKG_DELTA_NAME}
RUN curl -fLo /tmp/${PKG_DELTA_NAME} ${PKG_DELTA_URL} && \
    dpkg -i /tmp/${PKG_DELTA_NAME} && \
    rm /tmp/${PKG_DELTA_NAME}

RUN git clone https://github.com/tworuler/my-linux-config.git /tmp/my-linux-config && \
    bash /tmp/my-linux-config/install.sh && \
    rm -rf /tmp/my-linux-config

RUN apt install zoxide && echo 'eval "$(zoxide init zsh)"' >> /root/.zshrc

#----------------------------------------------------------------------------
# CPP Environment
#----------------------------------------------------------------------------
FROM base-dev AS cpp-dev
ARG CPP_PKGS="cmake ninja-build libopencv-dev llvm clang libc++-dev libc++abi-dev gdb"
RUN apt update && apt install -y ${CPP_PKGS}

#----------------------------------------------------------------------------
# Android Environment
#----------------------------------------------------------------------------
FROM cpp-dev AS android-dev
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
