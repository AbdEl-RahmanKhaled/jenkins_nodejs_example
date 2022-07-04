cat << EOF
apiVersion: v1
kind: Secret
metadata:
  name: nexus-docker
  namespace: dev
data:
  .dockercfg: `cat ~/.docker/config.json | base64 -w0`
type: kubernetes.io/dockercfg
EOF

cat << EOF | kubectl apply -f-
apiVersion: v1
kind: Secret
metadata:
  name: nexus-docker
  namespace: dev
data:
  .dockercfg: `cat ~/.docker/config.json | base64 -w0`
type: kubernetes.io/dockercfg
EOF
