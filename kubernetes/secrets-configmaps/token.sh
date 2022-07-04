TOKEN=`cat << EOF | base64
{
  "auths": {
    "10.107.185.142:8082": {
      "email": $USERNAME,
      "auth": `echo -n $PASS | base64 -w0`
    }
  }
}
EOF`

. ./kubernetes/secrets-configmaps/nexus-sec.sh

# cat << EOF | base64 | xargs -E . ./kubernetes/secrets-configmaps/nexus-sec.sh
# {
#   "auths": {
#     "10.107.185.142:8082": {
#       "email": $USERNAME,
#       "auth": echo -n $PASS | base64
#     }
#   }
# }
# EOF