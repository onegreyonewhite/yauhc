{{- define "capabilities.kubeVersion" -}}
{{- if .Values.global }}
{{- if .Values.global.kubeVersion }}
{{- .Values.global.kubeVersion -}}
{{- else }}
{{- default .Capabilities.KubeVersion.Version .Values.kubeVersion -}}
{{- end -}}
{{- else }}
{{- if .Capabilities.KubeVersion.Version -}}
{{- default .Capabilities.KubeVersion.Version .Values.kubeVersion -}}
{{- else -}}
{{- default .Capabilities.KubeVersion .Values.kubeVersion -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "capabilities.deployment.apiVersion" -}}
{{- if semverCompare "<1.14-0" (include "capabilities.kubeVersion" $) -}}
{{- print "extensions/v1beta1" -}}
{{- else -}}
{{- print "apps/v1" -}}
{{- end -}}
{{- end -}}

{{- define "capabilities.ingress.apiVersion" -}}
{{- if semverCompare "<1.14-0" (include "capabilities.kubeVersion" $) -}}
{{- print "extensions/v1beta1" -}}
{{- else if semverCompare "<1.19-0" (include "capabilities.kubeVersion" $) -}}
{{- print "networking.k8s.io/v1beta1" -}}
{{- else -}}
{{- print "networking.k8s.io/v1" -}}
{{- end }}
{{- end -}}
