from diagrams import Cluster, Diagram
from diagrams.k8s.infra import Node
from diagrams.k8s.compute import Pod, StatefulSet
from diagrams.k8s.network import Service
from diagrams.k8s.storage import PV, PVC, StorageClass
from diagrams.saas.cdn import Cloudflare
from diagrams.generic.device import Mobile
from diagrams.onprem.logging import Loki
from diagrams.onprem.monitoring import Grafana
from diagrams.onprem.database import PostgreSQL
from diagrams.generic.blank import Blank
from diagrams.oci.storage import ObjectStorage
from diagrams.onprem.network import Envoy

with Diagram("Infra Okampus", outformat="png"):
    with Cluster("Scaleway"):
        sos = ObjectStorage("Scaleway Object Storage")
        with Cluster("Node"):
            node = Node("Node")
            redisSvc = Service("Redis")
            redisSts = StatefulSet("RedisSet")
            okampusSvc = Service("Okampus")
            apps = []

            okampusPod = Pod("Okampus")
            redisPod = Pod("Redis")
            redisPod - redisSts
            apps.append(okampusSvc >> okampusPod)
            okampusPod >> sos
            apps.append(redisSvc >> redisPod)
            with Cluster("Monitoring"):
                grafana = Grafana("Grafana")
                grafana << Loki("Loki") >> sos
                grafana << Blank("Mimir") >> sos
                grafana << Blank("Tempo") >> sos
                apps.append(grafana)

        node << PostgreSQL("Scaleway Managed DB")
        apps << node << PV("Volume") << StorageClass("Scaleway Block Storage")
    node << Envoy("Envoy") << Cloudflare("Cloudflare") << Mobile("User")
