{{- define "imagePullSecret" }}
{{- with .Values.imageRegistryCredentials }}
{{- if .username }}
{{- printf "{\"auths\":{\"%s\":{\"username\":\"%s\",\"password\":\"%s\",\"email\":\"%s\",\"auth\":\"%s\"}}}" .registry .username .password .email (printf "%s:%s" .username .password | b64enc) | b64enc }}
{{- else -}}
{{- $existingSecret := (lookup "v1" "Secret" .Release.Namespace "acr-docker-secret") }}
{{- if $existingSecret }}
{{- printf "%s" index $existingSecret.data "dockerconfigjson" }}
{{- end -}}
{{- end -}}
{{- end }}
{{- end }}

