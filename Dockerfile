FROM ubuntu:24.04
RUN apt update && apt upgrade -y && \ 
    apt install -y mc ncdu tmux nano neofetch curl iperf3 tmux ncdu git htop vim wget pv nethogs bc git jq btop nmap net-tools nmon p7zip-full dnsutils iotop && \
    apt-get clean autoclean && apt-get autoremove --yes && rm -rf /var/lib/apt/
COPY vimrc /root/.vim/vimrc
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
    vim +slient +VimEnter +PlugInstall +qall
CMD ["/bin/bash"]