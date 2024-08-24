####  USE THE OFFICIAL NGINX IMAGE AS A BASE IMAGE #####
FROM nginx:alpine

####  COPY THE NGINX CONF TO THE CONFIGRATION FILE #####
COPY nginx/nginx.conf /etc/nginx/nginx.conf

####  COPY THE CODE TO THE WORKING DIRECTORY  ####
COPY html /usr/share/nginx/html
####  EXPOSE FROM THE PORT 90  ####
EXPOSE 90
