# Yet Another Universal Helm Chart (YAUHC)

Universal chart for building GitOps infrastructure.
It can be used both independently and as a dependent chart.

Core Philosophy: fewer parameters - faster setup.

## Parameters

### Deployments parameters

All deployments controlled by list of dicts named `deloyments`. Almost all values can be overrided with `generic` dict.
Deployment's pods updates their annotations when content of configmaps updates too. If deployment doesn't have `image`
parameter but have configs only configmap will be deployed. Without `configs` and `image` nothing will be deployed.


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
| `configPath`                    | no       | yes     | Path in container where configs will mounted.                | `{}`                                       |
