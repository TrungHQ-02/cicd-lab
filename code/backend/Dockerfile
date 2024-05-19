FROM node:14-alpine

# Set environment variables for the shell
# ENV NODE_ENV=production \
#     DB_USERNAME=root \
#     DB_PASSWORD=admin12345$ \
#     DB_DATABASE=app_database \
#     DB_HOST=192.168.88.112 \
#     DB_DIALECT=mysql\
#     DB_LOGGING=false


WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3000

CMD ["node", "src/server.js"]
