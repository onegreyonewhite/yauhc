{{- /*
yauhc.util.merge will merge two YAML templates and output the result.
This takes an array of three values:
- the top context
- the template name of the overrides (destination)
- the template name of the base (source)
*/}}
{{- define "yauhc.util.merge" -}}
{{- $top := first . -}}
{{- $overrides := fromYaml (include (index . 1) $top) | default (dict ) -}}
{{- $tpl := fromYaml (include (index . 2) $top) | default (dict ) -}}
{{- toYaml (merge $overrides $tpl) -}}
{{- end -}}

{{- /*
yauhc.util.getter will get first existing value and output result.
This takes an array of values and take only first.
*/}}
{{- define "yauhc.util.selecter" -}}
{{- range $val := . -}}
{{- if eq (typeOf $val) (typeOf nil) -}}
{{- $_ := "" -}}
{{- else -}}
{{- toYaml $val -}}
{{- break -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- /*
yauhc.util.getter will merge multiple values and output result.
This takes an array of three values and return result.
*/}}
{{- define "yauhc.util.merger" -}}
{{- $val := (index . 0) | default (dict ) -}}
{{- $generic := (index . 1) | default (dict ) -}}
{{- $global := (index . 2) | default (dict ) -}}
{{- $result := merge $val $generic $global -}}
{{- if $result -}}
{{- toYaml $result -}}
{{- end -}}
{{- end -}}

{{- /*
yauhc.util.getter will merge multiple values and output result.
This takes an array of three values and return result.
*/}}
{{- define "yauhc.util.makename" -}}
{{- $prefix := (index . 0) -}}
{{- $cur_values := (index . 1) | default (dict ) -}}
{{- $release := (index . 2) | default (dict ) -}}
{{- $name := "application" -}}
{{- if $cur_values.name -}}
{{- $name = $cur_values.name -}}
{{- else if $release.name -}}
{{- $name = $release.name -}}
{{- end -}}
{{- $result := printf "%s-%s" $prefix $name -}}
{{- toYaml ($result) -}}
{{- end -}}
