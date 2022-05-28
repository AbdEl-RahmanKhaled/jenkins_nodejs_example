. /$HOME/.env

cat << EOF | kubectl apply -f-
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-conf
data:
  RDS_HOSTNAME: $RDS_HOSTNAME
  RDS_PORT: "$RDS_PORT"
  REDIS_HOSTNAME: $REDIS_HOSTNAME
  REDIS_PORT: "$REDIS_PORT"
EOF