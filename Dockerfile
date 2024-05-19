# Використовуємо офіційний образ Nginx в якості бази
FROM nginx:latest

COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /usr/share/nginx/html/
COPY styles.css /usr/share/nginx/html/


# Вказуємо EXPOSE на порт 8040, на якому буде працювати Nginx
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
