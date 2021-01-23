FROM tomcat:8.5

RUN sed -i 's/port="8080"/port="80"/' ${CATALINA_HOME}/conf/server.xml

COPY ./Bowling.war /usr/local/tomcat/webapps/

CMD ["catalina.sh", "run"]
