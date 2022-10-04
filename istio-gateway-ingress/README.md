<!--- This file is intended to provide a place for contributors to document custom templates that are 
deployed alongside the configuration chart and include application-specific notes. --->

# __Istio Ingress Configuration Chart__

## __Template Descriptions__
N/A

<br>

## __Notes__
- [Helm install instructions](https://istio.io/latest/docs/setup/install/helm/)
- [Gateway config docs](https://istio.io/latest/docs/setup/additional-setup/gateway/)
- Must be installed _after_ installing istio-base and istiod.
- Should be installed in a separate namespace than Istiod for security purposes. See gateway config docs.
- Recommended namespace: `istio-ingress`
