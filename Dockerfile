FROM node:14
#FROM node:14 Since Dockerizing an application involves binding the runtime of the app - the first line From node:14 is basically importing the base image of Node.js runtime. Here 14 means version 14 of Node.js


WORKDIR /usr/src/app
#WORKDIR /usr/src/app sets the working directory in the container. All the operations will be now performed inside the app directory of containerized app.


COPY package*.json ./
#COPY package*.json ./ copies the package.json and package-lock.json file from local directory of app to working directory of containerized app.


RUN npm install
#RUN npm install - executes npm install command inside the container - which installs the node_libraries in the containerized app.


COPY . .
#COPY . . - copies the application code from the local directory of app to containerized app.


EXPOSE 3000
#EXPOSE 3000 - It tells docker that the application inside the container will be using the port 3000.


CMD ["node", "app.js"]
#CMD [“node”, “app.js”] - It defines the default command when container runs in this case it will be node app.js.
#The CMD command is defined in JSON Array format purposefully in order to avoid any conflicts if there are multiple arguments. This ensures each argument in the command is separated by a comma to avoid any confusion.