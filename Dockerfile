FROM node:alpine as builder

WORKDIR '/home/node'
USER node

COPY package.json .
RUN npm install

COPY ./public ./public
COPY ./src ./src
COPY ./yarn.lock ./yarn.lock

RUN npm run build

FROM nginx

# Generally is just informative for developers
# But for elasticbeanstalk it is necessary to expose the port
EXPOSE 80
COPY --from=builder /home/node/build /usr/share/nginx/html

# By default nginx runs the start command