FROM ubuntu

RUN apt-get update && apt-get install -y sudo git && adduser root sudo

WORKDIR /root
RUN git clone https://github.com/Qining/SetupWorkEnv && /root/SetupWorkEnv/DumpCurrentEnv.sh
WORKDIR /root/SetupWorkEnv

RUN ./DumpCurrentEnv.sh env_original.sh && ./basic.sh && ./cgdb.sh && ./python.sh && ./rtags.sh && ./vim.sh && ./neovim.sh && ./tmux.sh

CMD ["./test.sh"]
