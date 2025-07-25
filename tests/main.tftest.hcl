# TODO: Make main test more generic, e.g. "nginx" or "istio"
variables {
  name       = "test"
  namespace  = "default"
  class_name = "gke-l7-global-external-managed"

  addresses = [
    {
      type  = "NamedAddress"
      value = "test"
    }
  ]

  annotations = {
    "networking.gke.io/certmap" = "test"
  }

  listeners = [
    {
      name     = "http"
      protocol = "HTTP"
      port     = 80
    },
    {
      name     = "https"
      protocol = "HTTPS"
      port     = 443
    }
  ]
}

run "execute" {
  assert {
    condition     = length(kubernetes_manifest.default) != 0
    error_message = "Gateway resource has not been created"
  }
}
