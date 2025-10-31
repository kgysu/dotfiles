FROM debian:12

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y git curl wget sudo

ARG USERNAME=appuser
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

WORKDIR /home/$USERNAME


# add scripts for testing
ADD init.sh .
RUN chmod +x init.sh


USER $USERNAME


