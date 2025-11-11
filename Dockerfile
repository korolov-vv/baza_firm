FROM quay.io/keycloak/keycloak:26.4.0

WORKDIR /opt/keycloak

ENV KC_DB=postgres \
    KEYCLOAK_PROFILE_FEATURE_UPLOAD=enabled \
    KC_DB_URL=${KC_DB_URL} \
    KC_DB_USERNAME=${KC_DB_USERNAME} \
    KC_DB_PASSWORD=${KC_DB_PASSWORD} \
    KEYCLOAK_ADMIN=${KEYCLOAK_ADMIN} \
    KEYCLOAK_ADMIN_PASSWORD=${KEYCLOAK_ADMIN_PASSWORD}

COPY ./keycloak/keycloak-config/keycloak-config.json /opt/keycloak/data/import/keycloak-config.json
COPY ./keycloak/keycloak-customer-config/keycloak-customer-config.json /opt/keycloak/data/import/keycloak-customer-config.json

VOLUME ["/opt/keycloak/data"]

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
CMD [ "start-dev", "--http-port=8080", "--hostname=0.0.0.0", "--import-realm", "-Dkeycloak.profile.feature.token_exchange=enabled"]

EXPOSE 8080
