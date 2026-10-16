{{/* Create gomplate specific iteration over versions array */}}
{{- range $version := .versions -}}
  {{- $ctx := dict "latest" $.latest "version" $version }}

  {{/* Define paths to render the Dockerfiles to */}}
  {{- $outPath := printf "dockerfiles/%s/compose.yaml" $version.slug }}

  {{/* Render the inline template defined below */}}
  {{- tmpl.Exec "composefile" $ctx | file.Write $outPath }}
{{- end -}}

{{- define "composefile" -}}
################################################################
#                                                              #
#  WARNING: THIS FILE IS AUTO-GENERATED. DO NOT EDIT MANUALLY  #
#                                                              #
################################################################

name: open-integration-engine-novamap

{{/* Assign current version slug into a variable to carry it into the tags iteration */}}
{{- $slug := .version.slug -}}
services:
  {{- range .version.tags }}
    {{ print .distro "-" .type ":" }}
      image: ghcr.io/novamap-health/engine
      build:
        target: {{ .distro }}-{{ .type }}
        context: .
        platforms:
          - linux/amd64
          - linux/arm64
        tags:
          - ghcr.io/novamap-health/engine:{{ $slug }}-{{ .distro }}
          - ghcr.io/novamap-health/engine:{{ $slug }}-{{ .distro }}-{{ .type }}
          {{- if eq $slug $.latest }}
          - ghcr.io/novamap-health/engine:latest-{{ .distro }}-{{ .type }}
            {{- if eq .type "jre" }}
          - ghcr.io/novamap-health/engine:latest-{{ .distro }}
              {{- if eq .distro "alpine" }}
          - ghcr.io/novamap-health/engine:latest
              {{- end }}
            {{- end }}
          {{- end }}
  {{ end }}
{{- end }}
