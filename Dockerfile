FROM node:12 AS build
WORKDIR /app
COPY . /app
RUN npm install
RUN npm run build

FROM shippingdocker/php-composer:7.4 AS dependency
WORKDIR /app
COPY --from=build /app/ /app/

FROM php:7.4-apache
WORKDIR /var/www
COPY --from=build /app/ /app/
COPY --from=dependency /app/vendor/ /app/vendor/
RUN rm -Rf /var/www/html 
RUN rm -Rf /app/node_modules 
RUN ln -sFf /app/public /var/www/html
RUN chown www-data:www-data -R /app