{{/* vim: set filetype=mustache: */}}
{{/* Expand the name of the chart. */}}
{{- define "hasura.name" -}}
{{- printf "%s-%s" .Release.Name "hasura" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Hasura Selector labels */}}
{{- define "hasura.selectorLabels" -}}
app.kubernetes.io/name: {{ include "hasura.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/* Hasura labels */}}
{{- define "hasura.labels" -}}
{{ include "hasura.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/* Get the name for the vercel secret */}}
{{- define "hasura.vercel" -}}
{{- printf "%s-%s" (include "hasura.name" .) "vercel" -}}
{{- end -}}

{{/* Hasura configMap name */}}
{{- define "hasura.configMap" -}}
{{- printf "%s-%s" (include "hasura.name" .) "config" -}}
{{- end -}}
