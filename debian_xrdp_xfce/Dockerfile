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

FROM debian2vim as debian2vim2xrdp2xfce
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y \
    xfce4 \
    xfce4-clipman-plugin \
    xfce4-cpugraph-plugin \
    xfce4-netload-plugin \
    xfce4-screenshooter \
    xfce4-taskmanager \
    xfce4-terminal \
    xfce4-xkb-plugin \
    dbus-x11 \
    sudo \
    xorgxrdp \
    xrdp
RUN apt remove -y light-locker xscreensaver
RUN mkdir -p /etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml
COPY xfce4-desktop.xml /etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml
COPY xfwm4.xml /etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml
COPY ./xrdp-run.sh /usr/bin/run.sh
RUN chmod +x /usr/bin/run.sh
EXPOSE 3389


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
# mattermost
RUN curl -fsS -o- https://deb.packages.mattermost.com/setup-repo.sh | bash

# tabby-terminal
RUN wget https://github.com/Eugeny/tabby/releases/download/v1.0.227/tabby-1.0.227-linux-x64.deb \
    && (dpkg -i tabby-1.0.227-linux-x64.deb || apt-get update && apt-get install -f -y) && rm -f tabby-1.0.227-linux-x64.deb
# Thorium Browser
RUN wget https://github.com/Alex313031/thorium/releases/download/M130.0.6723.174/thorium-browser_130.0.6723.174_AVX2.deb \
    && (dpkg -i thorium-browser_130.0.6723.174_AVX2.deb || apt-get update && apt-get install -f -y) && rm -f thorium-browser_130.0.6723.174_AVX2.deb
# telegram-desktop
RUN wget -O telegram.tar.xz https://telegram.org/dl/desktop/linux \
    && tar -xf telegram.tar.xz \
    && mv Telegram /opt/telegram \
    && ln -sf /opt/telegram/Telegram /usr/bin/telegram \
    && rm -f telegram.tar.xz

# LibreWolf
#RUN wget -q -O - https://deb.librewolf.net/keyring.gpg | apt-key add - && \
#    echo "deb https://deb.librewolf.net $(lsb_release -sc) main" > /etc/apt/sources.list.d/librewolf.list

# Pale Moon
#RUN echo "deb http://download.opensuse.org/repositories/home:/stevenpusser/Debian_13/ /" > /etc/apt/sources.list.d/palemoon.list && \
#    wget -q -O - https://download.opensuse.org/repositories/home:/stevenpusser/Debian_13/Release.key | apt-key add -

# Lens IDE
#RUN wget -q -O - https://downloads.k8slens.dev/keys/gpgkey-public.asc | apt-key add - && \
#    echo "deb https://downloads.k8slens.dev/apt/debian stable main" > /etc/apt/sources.list.d/lens.list

RUN apt update && apt install -y \
    chromium \
    firefox \
    filezilla \
    remmina \
    remmina-plugin-vnc \
    vlc \
    libreoffice \
    code \
    mattermost-desktop \
    lens

    #dbeaver-ce \
    #librewolf \
    #palemoon \
    #lens \
    #obsidian \
    #tigervnc-viewer

RUN apt clean autoclean && apt autoremove -y && rm -rf /var/cache/apt /var/lib/apt/lists
ENTRYPOINT ["/usr/bin/run.sh"]


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
#docker run --rm -it -p 18933:3389 $(docker build -q --target debian2vim2xrdp2xfce .) qwe qwe yes