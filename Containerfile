### BASE-IMAGE ARGUMENTS
ARG SOURCE_IMAGE="fedora-bootc"
ARG SOURCE_TAG="latest"

### FETCH BASE-IMAGE
FROM quay.io/fedora/${SOURCE_IMAGE}:${SOURCE_TAG}

### COPY CONFIGUREATION FILES AND SCRIPTS
COPY sysfiles /tmp/sysfiles
COPY packages /tmp/packages
COPY scripts /tmp/scripts
COPY build.sh /tmp/build.sh

### RUN BUILD-SCRIPT AND MAKE COMMIT 
RUN /tmp/build.sh && \
    dnf clean all && \
    ostree container commit

### PERFORM ANALYSIS CHECKS
RUN bootc container lint
