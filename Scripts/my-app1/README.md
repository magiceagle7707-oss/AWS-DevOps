
#Requirements/functionalities of the app :

3 replicas
HTTP Liveness Probe
HTTP Readiness Probe
Startup Probe
Node Affinity (environment=production)
Toleration (env=prod:NoSchedule)
Expose it using a ClusterIP Service


kubectl label nodes <node-name> environment=production   # satisfies nodeAffinity requirement
kubectl taint nodes <node-name> env=prod:NoSchedule       # taint node; only tolerating pods land here
kubectl delete pods -l app=myapp                          # force reschedule so new affinity/taint rules apply