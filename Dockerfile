FROM ubuntu:focal

# Setup Timezone to Asia Kolkata
RUN ln -snf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime && \
  echo "Asia/Kolkata" | tee /etc/timezone && \
  apt-get -y update && \
  apt-get -y upgrade && \
  apt-get install -y --no-install-recommends \
  aria2 \
  curl \
  jq \
  htop \
  httpie \
  zip \
  unzip \
  tar \
  tmux \
  git \
  zsh \
  zsh-syntax-highlighting \
  zsh-autosuggestions \
  zstd \
  tree \
  locales \
  apt-transport-https \
  gnupg && \
  echo "deb http://ppa.launchpad.net/git-core/ppa/ubuntu impish main" | tee /etc/apt/sources.list.d/git-core-ubuntu-ppa-focal.list && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E1DD270288B4E6030699E45FA1715D88E1DF1F24 && \
  rm -rf /var/lib/apt/lists/*


# neovim
RUN curl -sL $(curl -sl "https://api.github.com/repos/neovim/neovim/releases/latest" | jq -r '.assets[].browser_download_url | select(endswith("appimage"))') -o nvim.appimage && \
  chmod u+x nvim.appimage && \
  install nvim.appimage /usr/local/bin/nvim && \
  rm nvim.appimage

# ripgrep
RUN curl -sL $(curl -sl "https://api.github.com/repos/BurntSushi/ripgrep/releases/latest" | jq -r '.assets[].browser_download_url | select(endswith("deb"))') -o ripgrep.deb && \
  dpkg -i ripgrep.deb && \
  rm ripgrep.deb

# bat
RUN curl -sL $(curl -sl "https://api.github.com/repos/sharkdp/bat/releases/latest" | jq -r '.assets[].browser_download_url | select((endswith("amd64.deb")) and (contains("musl") | not))') -o bat.deb && \
  dpkg -i bat.deb && \
  rm bat.deb

# exa
RUN curl -sL $(curl -sl "https://api.github.com/repos/ogham/exa/releases/latest" | jq -r '.assets[].browser_download_url | select((contains("exa-linux-x86_64")) and (contains("musl") | not))') -o exa.zip && \
  unzip -qq exa.zip -d exa && \
  install exa/bin/exa /usr/local/bin/exa && \
  rm -rf exa exa.zip

# delta
RUN curl -sL $(curl -sl "https://api.github.com/repos/dandavison/delta/releases/latest" | jq -r '.assets[].browser_download_url | select((endswith("amd64.deb")) and (contains("musl") | not))') -o delta.deb && \
  dpkg -i delta.deb && \
  rm delta.deb

# starship
RUN curl -sL $(curl -sl "https://api.github.com/repos/starship/starship/releases/latest" | jq -r '.assets[].browser_download_url | select(contains("starship-x86_64") and endswith("gnu.tar.gz"))') -o starship.tgz && \
  tar xf starship.tgz && \
  install starship /usr/local/bin/starship && \
  rm starship starship.tgz

RUN chsh -s /usr/bin/zsh root && \
  localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

WORKDIR /root

ENV LANG en_US.utf8
ENV APPIMAGE_EXTRACT_AND_RUN=1

RUN mkdir -p /root/.config/nvim
COPY config/init.vim .config/nvim/init.vim
RUN nvim +PlugUpdate +qa

COPY config/zshrc .zshrc
COPY config/zshenv .zshenv
COPY config/tmux.conf  .tmux.conf
COPY config/gitconfig .gitconfig
COPY config/starship.toml /root/.config/starship.toml

CMD [ "/usr/bin/zsh" ]

