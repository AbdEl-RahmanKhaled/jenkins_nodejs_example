cat << EOF | kubectl apply -f-
apiVersion: v1
kind: Secret
metadata:
  name: app-sec
data:
  RDS_USERNAME: `echo -n $USERNAME | base64 -w0`
  RDS_PASSWORD: `echo -n $PASS | base64 -w0`
EOF