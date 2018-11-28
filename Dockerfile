FROM ubuntu

COPY . /root/SetupWorkEnv

WORKDIR /root/SetupWorkEnv

RUN apt-get update && apt-get install -y sudo git && adduser root sudo

RUN ./DumpCurrentEnv.sh env_original.sh && ./basic.sh && ./cgdb.sh && ./python.sh && ./rtags.sh && ./vim.sh && ./neovim.sh && ./tmux.sh

CMD ["./test.sh"]
