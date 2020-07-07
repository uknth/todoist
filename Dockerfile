FROM golang:alpine

RUN apk add --update git bash openssl
RUN mkdir -p $GOPATH/src/github.com/sachaos/todoist

WORKDIR $GOPATH/src/github.com/sachaos/todoist

RUN git clone https://github.com/sachaos/todoist.git .

RUN go install
ARG TODOIST_API_TOKEN
RUN echo '{"token": "##TOKEN##", "color":"true"}' >> $HOME/.todoist.config.json
RUN sed -i 's|##TOKEN##|'$TODOIST_API_TOKEN'|g' $HOME/.todoist.config.json
RUN chmod 600 $HOME/.todoist.config.json

WORKDIR $GOPATH

RUN echo 'alias todoist="todoist sync && todoist"' >> $HOME/.bashrc
RUN source $HOME/.bashrc