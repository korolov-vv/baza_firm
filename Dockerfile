FROM quay.io/keycloak/keycloak:latest AS builder

# Enable health and metrics support
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true

# Configure a database vendor
ENV KC_DB=postgres

WORKDIR /opt/keycloak
# for demonstration purposes only, please make sure to use proper certificates in production instead
RUN keytool -genkeypair -storepass password -storetype PKCS12 -keyalg RSA -keysize 2048 -dname "CN=server" -alias server -ext "SAN:c=DNS:localhost,IP:127.0.0.1" -keystore conf/server.keystore
RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:latest
COPY --from=builder /opt/keycloak/ /opt/keycloak/

ENV KC_DB=postgres \
    KC_DB_URL=${KC_DB_URL} \
    KC_DB_USERNAME=${KC_DB_USERNAME} \
    KC_DB_PASSWORD=${KC_DB_PASSWORD} \
    KEYCLOAK_ADMIN=${KEYCLOAK_ADMIN} \
    KEYCLOAK_ADMIN_PASSWORD=${KEYCLOAK_ADMIN_PASSWORD} \
    KC_HOSTNAME=${KC_HOSTNAME} \
    KC_HTTP_PORT=8080 \
    KC_HTTP_ENABLED=true \
    KC_PROXY=edge \
    KEYCLOAK_PROFILE_FEATURE_UPLOAD=enabled \
    KC_HEALTH_ENABLED=true

COPY ./keycloak/keycloak-config/keycloak-config.json /opt/keycloak/data/import/keycloak-config.json
COPY ./keycloak/keycloak-customer-config/keycloak-customer-config.json /opt/keycloak/data/import/keycloak-customer-config.json

VOLUME ["/opt/keycloak/data"]

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
CMD [ "start-dev", "--import-realm", "-Dkeycloak.profile.feature.token_exchange=enabled"]

EXPOSE 8080
