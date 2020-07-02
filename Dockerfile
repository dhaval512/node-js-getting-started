FROM node:10.18.1

WORKDIR /app/

COPY . /app
RUN npm i

CMD [ "npm", "start"]
