FROM ubuntu:24.04 as ubuntu2vim
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt upgrade -y && \ 
    apt install -y mc ncdu tmux nano neofetch curl iperf3 tmux ncdu git htop vim wget pv nethogs bc git jq btop nmap \
    net-tools nmon p7zip-full dnsutils iotop && \
    apt clean autoclean && apt autoremove -y && rm -rf /var/cache/apt /var/lib/apt/lists
COPY vimrc /root/.vim/vimrc
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
    vim +slient +VimEnter +PlugInstall +qall
CMD ["/bin/bash"]

FROM ubuntu2vim as ubuntu2vim2xrdp2xfce
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
    xrdp && \
    apt remove -y light-locker xscreensaver && \
    apt clean autoclean && apt autoremove -y && rm -rf /var/cache/apt /var/lib/apt/lists
COPY ./ubuntu-run.sh /usr/bin/
RUN mv /usr/bin/ubuntu-run.sh /usr/bin/run.sh
RUN chmod +x /usr/bin/run.sh
EXPOSE 3389
ENTRYPOINT ["/usr/bin/run.sh"]
#docker run --rm -it -p 3389:3389 $(docker build -q --target ubuntu2vim2xrdp2xfce .) qwe qwe yes