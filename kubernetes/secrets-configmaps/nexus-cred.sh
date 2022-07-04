cat << EOF | kubectl apply -f-
apiVersion: v1
kind: Secret
metadata:
  name: nexus-cred
  namespace: dev
data:
  username: echo -n $USERNAME | base64
  password: echo -n $PASS | base64
EOF
