FROM ubuntu:21.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update

RUN apt-get install -y curl wget unzip git zsh gcc fzf ripgrep build-essential

WORKDIR /home/

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# RUN wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz
RUN wget https://github.com/neovim/neovim/releases/download/v0.6.1/nvim-linux64.tar.gz

RUN tar -xvzf nvim-linux64.tar.gz && rm nvim-linux64.tar.gz
RUN echo 'alias vi=/home/nvim-linux64/bin/nvim' >> ~/.zshrc

RUN apt install -y python3.10 python3-pip

RUN git clone https://github.com/vipul-sharma20/nvim-config ~/.config/nvim
RUN git clone --depth 1 https://github.com/wbthomason/packer.nvim \
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# TODO: Also setup Treesitter plugins during build time instead of setting up
# during runtime as it'll require internet
RUN /home/nvim-linux64/bin/nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

# TODO: Add other LSP stuff here
RUN pip3 install python-lsp-server

CMD ["/home/nvim-linux64/bin/nvim"]

