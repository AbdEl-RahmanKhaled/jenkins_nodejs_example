cat << EOF | base64 | nexus-sec.sh -
{
  "auths": {
    "10.107.185.142:8082": {
      "email": $USERNAME,
      "auth": echo -n $PASS | base64
    }
  }
}
EOF