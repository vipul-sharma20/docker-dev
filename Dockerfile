FROM ubuntu:16.04

RUN apt-get -y update
RUN apt-get install -y curl wget unzip git nodejs npm tmux libffi-dev zsh silversearcher-ag

WORKDIR /home/

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

RUN wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz
RUN tar -xvzf nvim-linux64.tar.gz && rm nvim-linux64.tar.gz
RUN echo 'alias vi=/home/nvim-linux64/bin/nvim' >> ~/.zshrc

RUN git clone --depth 1 https://github.com/junegunn/fzf.git /home/.fzf
RUN /home/.fzf/install --all

RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:deadsnakes/ppa
RUN apt-get -y update
RUN apt-get -y install python3.8 python3-pip
RUN pip3 install neovim

RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

RUN git clone https://github.com/vipul-sharma20/vimrc
RUN mkdir -p ~/.config/nvim/
RUN cp vimrc/init.vim ~/.config/nvim/
RUN cp -r vimrc/ /root/
RUN touch /root/vimrc/vimrc.d/work.vim

WORKDIR /home/

RUN curl -sL install-node.now.sh/lts | bash -s -- --yes
