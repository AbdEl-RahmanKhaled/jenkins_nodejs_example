cat << EOF | kubectl apply -f-
apiVersion: v1
data:
  .dockercfg: $1
kind: Secret
metadata:
  name: nexus-docker
type: kubernetes.io/dockercfg
EOF