{% from "vmwaretools/map.jinja" import vmwaretools with context %}

{% set config = {
    'packageurl': salt['pillar.get']('vmwaretools:packageurl', ''), 
} %}

vmwaretools:
  require:
    - pkg: vmwaretools.dependencies
  cmd.run:
    - unless: /usr/sbin/vmware-checkvm
{% if config.packageurl %}
    - name: curl {{ config.packageurl }} | tar zx -C /tmp ; /tmp/vmware-tools-distrib/vmware-install.pl -d
{% endif %}

vmwaretools.dependencies:
  pkg.installed:
    - pkgs:
{% for dep in vmwaretools.dependencies %}
      - {{ dep }}
{% endfor %}
