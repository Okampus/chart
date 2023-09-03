{{/* vim: set filetype=mustache: */}}
{{/* Expand the name of the chart. */}}
{{- define "okampus.name" -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Create chart name and version as used by the chart label. */}}
{{- define "okampus.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "hasura.name" -}}
{{- printf "%s-%s" .Release.Name "hasura" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Hasura Selector labels */}}
{{- define "hasura.selectorLabels" -}}
app.kubernetes.io/name: {{ include "hasura.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/* Okampus Selector labels */}}
{{- define "okampus.selectorLabels" -}}
app.kubernetes.io/name: {{ include "okampus.name" . }}
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
helm.sh/chart: {{ include "okampus.chart" . }}
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
{{- define "hasura.dbMetadataSecret" -}}
{{- printf "%s-%s" (include "hasura.name" .) "postgres" -}}
{{- end -}}

{{/* Get the name for the Postgres secret */}}
{{- define "hasura.adminSecret" -}}
{{- printf "%s-%s" (include "hasura.name" .) "admin" -}}
{{- end -}}

{{/* Get the name for the auth Postgres secret (hardcoded for use as datasource in infra) */}}
{{- define "okampus.dbAuthSecret" -}}
okampus-psql-auth
{{- end -}}

{{/* Get the name for the tenant Postgres secret (hardcoded for use as datasource in infra) */}}
{{- define "okampus.dbTenantSecret" -}}
okampus-psql-tenant
{{- end -}}

{{/* Get the name for the universal db Postgres secret */}}
{{- define "okampus.dbUniversalSecret" -}}
okampus-psql-universal
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