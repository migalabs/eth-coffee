# syntax=docker/dockerfile:1
FROM golang:1.17-alpine
RUN apk add --update git
RUN apk add --update gcc
RUN apk add --update g++
RUN apk add --update openssh-client
RUN apk add --update make

RUN mkdir /app
WORKDIR /app
RUN git clone https://github.com/cortze/eth-cl-state-analyzer.git
WORKDIR /app/eth-cl-state-analyzer

RUN go get
RUN go build -o ./build/eth-cl-state-analyzer

ENTRYPOINT ["./build/eth-cl-state-analyzer"]