# Container to act as an ssh bastion host

## Deployment example

```yaml
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: kubeforge-bastion
  namespace: kubeforge-services
  labels:
    app: bastion
spec:
  replicas: 1
  strategy:
    type: Recreate
  selector:
    matchLabels:
      app: bastion
  template:
    metadata:
      labels:
        app: bastion
    spec:
      containers:
      - name: bastion
        image: kubeforge/bastion
        volumeMounts:
        - name: ssh-keys
          mountPath: "/root/.ssh/"
          readOnly: true
      volumes:
      - name: ssh-keys
        secret:
          secretName: ssh-keys-public
          items:
          - key: "userdata"
            path: "authorized_keys"
```
