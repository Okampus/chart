{{/* vim: set filetype=mustache: */}}
{{/* Expand the name of the chart. */}}
{{- define "okampus.chartName" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "okampus.name" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "hasura.name" -}}
{{- printf "%s-%s" .Release.Name "hasura" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Hasura Selector labels */}}
{{- define "hasura.selectorLabels" -}}
app.kubernetes.io/name: {{ printf "%s-%s" .Chart.Name "hasura" | trunc 63 | trimSuffix "-" }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/* Okampus Selector labels */}}
{{- define "okampus.selectorLabels" -}}
app.kubernetes.io/name: {{ include "okampus.chartName" . }}
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

{{/* Okampus labels */}}
{{- define "okampus.labels" -}}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{ include "okampus.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/* Get the name for the various key secrets */}}
{{- define "okampus.keysSecret" -}}
{{- printf "%s-%s" (include "okampus.name" .) "keys" -}}
{{- end -}}

{{/* Get the name for the s3 secret */}}
{{- define "okampus.s3Secret" -}}
{{- printf "%s-%s" (include "okampus.name" .) "s3" -}}
{{- end -}}

{{/* Get the name for the Postgres secret */}}
{{- define "hasura.postgresSecret" -}}
{{- printf "%s-%s" (include "hasura.name" .) "postgres" -}}
{{- end -}}

{{/* Get the name for the Postgres secret */}}
{{- define "okampus.postgresSecret" -}}
{{- printf "%s-%s" (include "okampus.name" .) "postgres" -}}
{{- end -}}

{{/* Get the name for the Novu secret */}}
{{- define "okampus.novuSecret" -}}
{{- printf "%s-%s" (include "okampus.name" .) "novu" -}}
{{- end -}}

{{/* Get the name for the admin secret */}}
{{- define "okampus.adminSecret" -}}
{{- printf "%s-%s" (include "okampus.name" .) "admin" -}}
{{- end -}}

{{/* Get the name for the base tenant secret */}}
{{- define "okampus.baseTenantSecret" -}}
{{- printf "%s-%s" (include "okampus.name" .) "basetenant" -}}
{{- end -}}

{{/* Hasura configMap name */}}
{{- define "hasura.configMap" -}}
{{- printf "%s-%s" (include "hasura.name" .) "config" -}}
{{- end -}}

{{/* Okampus configMap name */}}
{{- define "okampus.configMap" -}}
{{- printf "%s-%s" (include "okampus.name" .) "config" -}}
{{- end -}}