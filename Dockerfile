# ---------- runtime stage (your Liberty base) ----------
FROM icr.io/appcafe/websphere-liberty:full-java11-openj9-ubi

ARG LIBERTY_JDK_PATH="/opt/ibm/java/jre/lib/security"
ARG LIBERTY_IMAGE_TYPE="full"
ARG APP_REMOVE_SRC_CODE=false

USER root

# RHEL/UBI packages (dnf/yum)
RUN set -eux; \
  if command -v dnf >/dev/null 2>&1; then \
    dnf -y update && \
    dnf -y install \
      python3 python3-pip \
      curl tar gzip unzip which vim-minimal \
      rsync sshpass telnet tzdata \
      libjpeg-turbo-devel libjpeg-turbo-utils \
      openssh-clients && \
    dnf clean all; \
  else \
    yum -y update && \
    yum -y install \
      python3 python3-pip \
      curl tar gzip unzip which vim-minimal \
      rsync sshpass telnet tzdata \
      libjpeg-turbo-devel libjpeg-turbo-utils \
      openssh-clients && \
    yum clean all; \
  fi; \
  ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime

# Minimal Python footprint
RUN python3 -m pip install --no-cache-dir --upgrade pip && \
    python3 -m pip install --no-cache-dir requests

# Env you kept
ENV S2I_SCRIPTS_PATH="/usr/local/s2i" \
    HOME="/opt/app-root/src" \
    WLP_DEBUG_ADDRESS="7777" \
    JOLOKIA_PORT="8778" \
    ENABLE_DEBUG="false" \
    ENABLE_JOLOKIA="true" \
    S2I_DESTINATION="/tmp" \
    JOLOKIA_VERSION="1.3.5" \
    JAVA_AND_LIBERTY_VERSION="$JAVA_VERSION-$LIBERTY_VERSION" \
    TARGET_ENVIRONMENT="ps" \
    JVMOPTS="/config/jvm.options"

# Liberty config
COPY contrib/server.xml   /config/server.xml
COPY contrib/server.env   /config/server.env
COPY contrib/jvm.options  /config/jvm.options

# Copy the WAR built in the first stage into /config/dropins
COPY --from=build /src/target/app.war /config/dropins/app.war

# (Optional) Install features; ignore rc=22 if already present
RUN set -e; \
  installUtility install --acceptLicense adminCenter-1.0 ssl-1.0 monitor-1.0 || \
  { rc=$?; if [ "$rc" -eq 22 ]; then echo "Features already installed — continuing."; else exit "$rc"; fi; }

# Permissions
RUN mkdir -p /config/project /logs && \
    chown -R 1001:0 /config /logs /opt/ibm/wlp && \
    chmod -R g+rwX /config /logs /opt/ibm/wlp

WORKDIR $HOME
EXPOSE 9080 9443 7777
USER 1001
CMD ["/opt/ibm/wlp/bin/server","run","defaultServer"]
