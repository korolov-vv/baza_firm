FROM quay.io/keycloak/keycloak:26.4.0

WORKDIR /opt/keycloak

ENV KC_DB=bazafirm-keycloak \
    KC_DB_URL=${KC_DB_URL} \
    KC_DB_USERNAME=${KC_DB_USERNAME} \
    KC_DB_PASSWORD=${KC_DB_PASSWORD} \
    KEYCLOAK_ADMIN=${KEYCLOAK_ADMIN} \
    KEYCLOAK_ADMIN_PASSWORD=${KEYCLOAK_ADMIN_PASSWORD}

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
CMD [ "start" ]

EXPOSE 8080
