FROM debian:12

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y git curl wget sudo fd-find fzf nodejs golang-go neovim

ARG USERNAME=appuser
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

WORKDIR /home/$USERNAME


# add scripts for testing
RUN mkdir .dotfiles
ADD . .dotfiles
RUN chown appuser:appuser .dotfiles

RUN mkdir -p .config/nvim
RUN touch .config/nvim/test.md
RUN chown -R appuser:appuser .config


USER $USERNAME

