FROM node:18-alpine

env PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
RUN mkdir -p /opt/express-hello-world
COPY . /opt/express-hello-world
WORKDIR /opt/express-hello-world

RUN npm install
CMD ["npm", "start"]

