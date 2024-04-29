# Basierend auf der offiziellen Node.js 16-Buster-Image
FROM node:16-buster-slim
 
# Setze das Arbeitsverzeichnis im Container
WORKDIR /app
 
# Kopiere 'package.json' und 'package-lock.json' (falls vorhanden)
COPY package*.json ./
 
# Installiere Projekt-Abhängigkeiten
RUN npm install
 
# Kopiere alle Projektdateien ins Arbeitsverzeichnis im Container
COPY . .
 
# Baue die Anwendung für die Produktion
RUN npm run build
 
# Installiere einen einfachen HTTP-Server zum Bedienen der Anwendung
RUN npm install -g http-server
 
# Öffne Port 8080, um darauf zugreifen zu können
EXPOSE 8080
 
# Starte den HTTP-Server, um die gebaute Anwendung zu bedienen
CMD ["http-server", "dist"]