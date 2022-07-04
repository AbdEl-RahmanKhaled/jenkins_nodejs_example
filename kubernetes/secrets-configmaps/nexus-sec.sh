echo $1
cat << EOF | kubectl apply -f-
apiVersion: v1
data:
  .dockercfg: $1
kind: Secret
metadata:
  name: nexus-docker
  namespace: dev
type: kubernetes.io/dockercfg
EOF