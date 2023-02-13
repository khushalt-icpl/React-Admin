# Fetching the node image as per the requirment
FROM node:18.14.0

#Declaring the env
ENV PATH /app/node_modules/.bin:$PATH

#installing all the dependencies
COPY **/package.json **/package-lock.json ./

#copy the working dirictory
WORKDIR /usr/app
COPY ./ /usr/app
RUN npm install
RUN npm install react-scripts@1.1.5

#add app
COPY . .


#start app
CMD ["npm","start"]