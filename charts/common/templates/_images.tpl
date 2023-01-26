{{/*
Create the image path for the passed in image field
*/}}
{{- define "common.images.image" -}}
{{- if eq (substr 0 7 .version) "sha256:" -}}
{{- printf "%s/%s@%s" .registry .repository .version -}}
{{- else -}}
{{- printf "%s/%s:%s" .registry .repository .version -}}
{{- end -}}
{{- end -}}

{{/*
Create the combined registry and repository for the passed in image field
*/}}
{{- define "common.images.registryRepository" -}}
{{- printf "%s/%s" .registry .repository -}}
{{- end -}}