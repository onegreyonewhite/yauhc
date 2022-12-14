# Yet Another Universal Helm Chart (YAUHC)

Universal chart for building GitOps infrastructure.
It can be used both independently and as a dependent chart.

Core Philosophy: fewer parameters - faster setup.

## Usage

```bash
helm repo add yauhc https://gitlab.com/api/v4/projects/40345586/packages/helm/stable
helm repo update
helm upgrade project YAUCH -f ./values.yaml --install --wait
```

Where:
- `https://gitlab.com/api/v4/projects/40345586/packages/helm/stable` - public helm repository.
- `./values.yaml` - path to infrastructure's values.

#### Examples

`samples` contains examples for some deployment cases.

- `samples/simple_https_service.yaml` - An example of how to deploy a simple http service with tls 
  (with cert-manager and issuer installed)
- `samples/simple_https_microservices.yaml` - An example of how to deploy multiple services and connect
  them in one endpoint behind an https proxy (with cert-manager and issuer installed).



## Parameters

### Deployments parameters

All deployments controlled by list of dicts named `deloyments`. Almost all values can be overrided with `generic` dict.
Deployment's pods updates their annotations when content of configmaps updates too. If deployment doesn't have `image`
parameter but have configs only configmap will be deployed. Without `configs` and `image` nothing will be deployed.
For deployments with `port` parameter automatically creates service with same port and same selector.


| Name                            | Required | Generic | Description                                                  | Value                                      |
|---------------------------------|----------|---------|--------------------------------------------------------------|--------------------------------------------|
| `image`                         | yes      | yes     | Docker image that will be used                               | `''`                                       |
| `name`                          | no       | no      | Name for deployment,configmap,service,ingress and selectors. | `'{.Release.Name}-{index in deployments}'` |
| `labels`                        | no       | yes     | Labels to add to all deployments.                            | `{}`                                       |
| `annotations`                   | no       | yes     | Annotations to add to all deployments and pods.              | `{}`                                       |
| `revisionHistoryLimit`          | no       | yes     | Limitation of old replicasets should be kept.                | ``                                         |
| `replicaCount`                  | no       | yes     | Deployment replicas count.                                   | ``                                         |
| `strategy`                      | no       | yes     | Deployment strategy.                                         | `{}`                                       |
| `terminationGracePeriodSeconds` | no       | yes     | Integer setting the termination grace period for the pods.   | `30`                                       |
| `imagePullPolicy`               | no       | yes     | Docker image pull policy.                                    | `'IfNotPresent'`                           |
| `command`                       | no       | yes     | Container command override (list or string).                 | `[]`                                       |
| `env`                           | no       | yes     | Dict of extra environment variables.                         | `{}`                                       |
| `readinessProbe`                | no       | yes     | Readiness probe object for container.                        | `{}`                                       |
| `livenessProbe`                 | no       | yes     | Liveness probe object for container.                         | `{}`                                       |
| `startupProbe`                  | no       | yes     | Startup probe object for container.                          | `{}`                                       |
| `resources`                     | no       | yes     | The resources requests and limits for container.             | `{}`                                       |
| `nodeSelector`                  | no       | yes     | Node labels for Hook Job; pods assignment.                   | `{}`                                       |
| `affinity`                      | no       | yes     | Affinity for deployment; replicas pods assignment.           | `{}`                                       |
| `tolerations`                   | no       | yes     | Tolerations for deployment; replicas pods assignment.        | `{}`                                       |
| `configs`                       | no       | yes     | Dict with filenames and their content.                       | `{}`                                       |
| `configPath`                    | no       | yes     | Path in container where configs will mounted.                | `/etc/{name}`                              |
| `configmapSuffix`               | no       | yes     | Additional suffix for configmap name.                        | `settings`                                 |
| `port`                          | no       | yes     | Port exposed from container in deployment.                   | ``                                         |
| `portType`                      | no       | yes     | Type of a service.                                           | ``                                         |
| `serviceAnnotations`            | no       | yes     | Annotations to add to services for deployment.               | `{}`                                       |
| `domain`                        | no       | yes     | Domain name for deployment's ingress.                        | `''`                                       |
| `issuer`                        | no       | yes     | Name of cert-manager's issuer for ingress tls.               | `''`                                       |
| `endpointPath`                  | no       | yes     | Name of path for microservice style ingress.                 | `''`                                       |

#### Examples

`samples` contains examples for some deployment cases.

- `samples/simple_https_service.yaml` - An example of how to deploy a simple http service with tls 
  (with cert-manager and issuer installed)
- `samples/simple_http_service.yaml` - An example of how to deploy a simple http service without tls but with QoS.
- `samples/simple_https_microservices.yaml` - An example of how to deploy multiple services and connect
  them in one endpoint behind an https proxy (with cert-manager and issuer installed).
- `samples/wrap_external_services.yaml` - An example with deployment only services and ingress without payload.
