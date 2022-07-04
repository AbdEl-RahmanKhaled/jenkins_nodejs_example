cat << EOF
apiVersion: v1
kind: Secret
metadata:
  name: nexus-docker
  namespace: dev
data:
  .dockercfg: $TOKEN
type: kubernetes.io/dockercfg
EOF

cat << EOF | kubectl apply -f-
apiVersion: v1
kind: Secret
metadata:
  name: nexus-docker
  namespace: dev
data:
  .dockercfg: $TOKEN
type: kubernetes.io/dockercfg
EOF
