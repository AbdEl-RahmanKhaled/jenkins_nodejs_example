echo $1
echo $TOKEN
cat << EOF | kubectl apply -f-
apiVersion: v1
data:
  .dockercfg: $TOKEN
kind: Secret
metadata:
  name: nexus-docker
  namespace: dev
type: kubernetes.io/dockercfg
EOF