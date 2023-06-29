#строим имедж
FROM node
# create директории приложения
WORKDIR /vue-app
#copy from(.) to(/node-app)
COPY . /vue-app

RUN npm install
#port
EXPOSE 8080

CMD [ "npm","run","serve" ]