FROM debian:13 as debian2vim
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt upgrade -y && \ 
    apt install -y mc ncdu tmux nano curl iperf3 tmux ncdu git htop vim wget pv nethogs bc git jq btop nmap \
    net-tools nmon p7zip-full dnsutils iotop gnupg node-ws apt-transport-https gpg && \
    apt clean autoclean && apt autoremove -y && rm -rf /var/cache/apt /var/lib/apt/lists
COPY vimrc /root/.vim/vimrc
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
    vim +slient +VimEnter +PlugInstall +qall
CMD ["/bin/bash"]

FROM debian2vim as debian2vim2xrdp2lxqt
ENV DEBIAN_FRONTEND=noninteractive
RUN echo "deb http://mirror.yandex.ru/debian/ trixie main contrib non-free" > /etc/apt/sources.list && \
    echo "deb http://mirror.yandex.ru/debian/ trixie-updates main contrib non-free" >> /etc/apt/sources.list && \
    echo "deb http://mirror.yandex.ru/debian-security/ trixie-security/updates main contrib non-free" >> /etc/apt/sources.list
RUN apt-get update && apt-get install -y --no-install-recommends \
    lxqt-core lxqt-session openbox lightdm pcmanfm-qt qterminal breeze-icon-theme locales sudo crudini \
    lxqt-policykit \
    pulseaudio \
    pavucontrol \
    udisks2 lxqt-config lxqt-runner lxqt-globalkeys\
    dbus-x11 xorgxrdp xrdp xorg 
COPY ./xrdp-run.sh /usr/bin/run.sh
RUN chmod +x /usr/bin/run.sh
COPY ./globalkeyshortcuts.conf /etc/.globalkeyshortcuts.conf
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8
#RUN apt clean autoclean && apt autoremove -y && rm -rf /var/cache/apt /var/lib/apt/lists
EXPOSE 3389
ENTRYPOINT ["/usr/bin/run.sh"]
#docker run --rm -it -p 18933:3389 $(docker build -q --target debian2vim2xrdp2lxqt .) qwe qwe yes


FROM debian2vim2xrdp2lxqt as debian2vim2xrdp2lxqt2soft
#firefox
RUN mkdir -p /etc/apt/keyrings && \
    wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null && \
    echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" > /etc/apt/sources.list.d/mozilla.list && \
    echo 'Package: *\nPin: origin packages.mozilla.org\nPin-Priority: 1000' > /etc/apt/preferences.d/mozilla
#code
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg \
    && install -D -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/microsoft.gpg \
    && rm -f microsoft.gpg \
    && echo "Types: deb\nURIs: https://packages.microsoft.com/repos/code\nSuites: stable\nComponents: main\nArchitectures: amd64,arm64,armhf\nSigned-By: /usr/share/keyrings/microsoft.gpg" > /etc/apt/sources.list.d/vscode.sources
#lens
RUN curl -fsSL https://downloads.k8slens.dev/keys/gpg | gpg --dearmor | tee /usr/share/keyrings/lens-archive-keyring.gpg > /dev/null \
    && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/lens-archive-keyring.gpg] https://downloads.k8slens.dev/apt/debian stable main" | tee /etc/apt/sources.list.d/lens.list > /dev/null
# tabby-terminal
RUN wget https://github.com/Eugeny/tabby/releases/download/v1.0.227/tabby-1.0.227-linux-x64.deb \
    && (dpkg -i tabby-1.0.227-linux-x64.deb || apt-get update && apt-get install -f -y) && rm -f tabby-1.0.227-linux-x64.deb
# Thorium Browser
RUN wget https://github.com/Alex313031/thorium/releases/download/M130.0.6723.174/thorium-browser_130.0.6723.174_AVX2.deb \
    && (dpkg -i thorium-browser_130.0.6723.174_AVX2.deb || apt-get update && apt-get install -f -y) && rm -f thorium-browser_130.0.6723.174_AVX2.deb

RUN apt update && apt install -y \
    chromium \
    firefox \
    filezilla \
    remmina \
    remmina-plugin-vnc \
    vlc \
    libreoffice

#crome
#thorium
#librewolf
#palemoon
#tabby
#vscode
#lens
#obsidian
#remmina
#filezilla
#vncviewer
#vlc
#telegram
#mattermost
#libreoffice
#dbeawer

#docker run --rm -it -p 18933:3389 $(docker build -q --target debian2vim2xrdp2lxqt2soft .) qwe qwe yes