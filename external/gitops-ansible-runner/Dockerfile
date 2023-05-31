FROM registry.access.redhat.com/ubi9/python-39
USER 0
RUN \
  dnf update -y && \
  dnf clean all && \
  python -m pip install -U pip && \
  python -m pip install ansible && \
  python -m pip install dnspython && \
  python -m pip install jmespath && \
  python -m pip install netaddr && \
  python -m pip install openshift && \
  curl -sL https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux.tar.gz | \
    tar -C /usr/local/bin -xvzf - oc kubectl
USER 1001
