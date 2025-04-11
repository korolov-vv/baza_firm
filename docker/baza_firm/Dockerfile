FROM eclipse-temurin:21-jdk AS builder

WORKDIR /build

RUN apt-get update && apt-get install -y git openssh-client maven && apt-get clean

RUN apt-get update && apt-get install -y wget unzip
RUN wget https://services.gradle.org/distributions/gradle-8.5-bin.zip -P /tmp
RUN unzip -d /opt/gradle /tmp/gradle-8.5-bin.zip
ENV PATH="/opt/gradle/gradle-8.5/bin:${PATH}"

COPY id_rsa /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa && \
    ssh-keyscan -H github.com >> /root/.ssh/known_hosts

RUN git clone --branch develop git@github.com:korolov-vv/baza-firm.git . && \ 
    git pull 

RUN rm -r /root/.ssh
RUN gradle clean build -x test

FROM eclipse-temurin:21-jdk
WORKDIR /app
COPY --from=builder /build/build/libs/*.jar app.jar

EXPOSE 18080
ENTRYPOINT ["java", "-jar", "app.jar"]