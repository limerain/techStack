# helm repo add tyk-helm https://helm.tyk.io/public/helm/charts/

helm upgrade -i tyk-redis oci://registry-1.docker.io/bitnamicharts/redis -f values-redis.yaml
helm upgrade -i tyk tyk-helm/tyk-oss -f values-oss.yaml
    # --set global.secrets.APISecret="foo" \
    # --set global.redis.addrs="{tyk-redis-master.tyk.svc.cluster.local:6379}" \
    # --set global.redis.passSecret.name=tyk-redis \
    # --set global.redis.passSecret.keyName=redis-password