exports.redis_key = "{{ redis_key }}";
exports.bugsnag_key = "{{ bugsnag_key }}";

exports.redis_port = {{ redis_port }};
exports.redis_host = '{{ redis_ip }}';

exports.statsd_ip = "{{ apps.graphite.ip }}";
exports.statsd_port = {{ apps.graphite.statsd }};
