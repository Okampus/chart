{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "okampus.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "okampus.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "okampus.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Hasura labels
*/}}
{{- define "hasura.labels" -}}
helm.sh/chart: {{ include "okampus.chart" . }}
{{ include "hasura.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Okampus labels
*/}}
{{- define "okampus.labels" -}}
helm.sh/chart: {{ include "okampus.chart" . }}
{{ include "okampus.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Hasura Selector labels
*/}}
{{- define "hasura.selectorLabels" -}}
app.kubernetes.io/name: hasura
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Okampus Selector labels
*/}}
{{- define "okampus.selectorLabels" -}}
app.kubernetes.io/name: {{ include "okampus.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Get the name for the various key secrets
*/}}
{{- define "okampus.keysSecret" -}}
{{- printf "%s-%s" (include "okampus.fullname" .) "keys" -}}
{{- end -}}

{{/*
Get the name for the s3 secret
*/}}
{{- define "okampus.s3Secret" -}}
{{- printf "%s-%s" (include "okampus.fullname" .) "s3" -}}
{{- end -}}

{{/*
Get the name for the Hasura metadata db secret
*/}}
{{- define "hasure.dbSecret" -}}
hasura-db
{{- end -}}

{{/*
Get the name for the core db secret
*/}}
{{- define "app.dbSecret" -}}
{{- printf "%s-%s" (include "okampus.fullname" .) "db" -}}
{{- end -}}

{{/*
Get the name for the Postgres secret
*/}}
{{- define "hasura.postgresSecret" -}}
hasura-postgres
{{- end -}}

{{/*
Get the name for the Postgres secret
*/}}
{{- define "okampus.postgresSecret" -}}
{{- printf "%s-%s" (include "okampus.fullname" .) "postgres" -}}
{{- end -}}

{{/*
Get the name for the Novu secret
*/}}
{{- define "okampus.novuSecret" -}}
{{- printf "%s-%s" (include "okampus.fullname" .) "novu" -}}
{{- end -}}

{{/*
Get the name for the admin secret
*/}}
{{- define "okampus.adminSecret" -}}
{{- printf "%s-%s" (include "okampus.fullname" .) "admin" -}}
{{- end -}}

{{/*
Get the name for the base tenant secret
*/}}
{{- define "okampus.baseTenantSecret" -}}
{{- printf "%s-%s" (include "okampus.fullname" .) "basetenant" -}}
{{- end -}}

{{/*
Hasura configMap name
*/}}
{{- define "hasura.configMap" -}}
hasura-config
{{- end -}}

{{/*
Okampus configMap name
*/}}
{{- define "okampus.configMap" -}}
{{- printf "%s-%s" (include "okampus.fullname" .) "config" -}}
{{- end -}}