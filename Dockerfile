#snafuz/pyvim
#
# VIM based Python Development Environment
#
#
FROM  python:3.8-slim-buster
RUN apt-get update && \
    apt-get install -y apt-file && \ 
    apt-get update && \
    apt-get install -y python3-dev git make gcc libncurses5-dev libncursesw5-dev && \
    rm -rf /var/lib/apt/lists/* && \
    git clone https://github.com/vim/vim /usr/local/src/vim && \
    cd /usr/local/src/vim && \
    make distclean && \
    cd /usr/local/src/vim/src && \
    ./configure --with-features=huge \
            --enable-largefile \
            --disable-netbeans \
            --enable-python3interp=yes \
            --with-python3-config-dir=$(python3-config --configdir) \
            --enable-fail-if-missing \
            --enable-cscope && \
    make && \
    make install && \
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim && \
    apt-get remove -y make gcc libncurses5-dev libncursesw5-dev apt-file && \
    apt-get autoremove -y
RUN echo 'export PS1="pyvim\\$ "' > ~/.bashrc
ADD template.vimrc /root/.vimrc
RUN pip install pudb && \
    vim -c 'PluginInstall' -c 'qa!' && \
    cd /root/.vim/bundle/jedi-vim && \
    git submodule update --init --recursive
WORKDIR /root


