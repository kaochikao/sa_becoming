
Global vs. Regional Model
- GCP: instrinsically global
    - Easier to handle latency & failure in a global way
- AWS: instrinsically region-scoped
    - simplifies data sovereignty
    - Could be more sensitive to multi-region / global failure modes


GCP Networking:
- Zone -> Region (in avg, 3 zones) -> `Multi-Region` -> `Private Global Network` -> POP -> Global system
    - 和AWS很不一樣
- Normal network: routes via Internet to edge location closest to `destination`.
- GCP network: routes so traffic enters from Internet at edge location closest to `source`.

Pricing: 
- Provisioned: "make sure you're ready to handle X"
- Usage: "handle whatever I use, and charge me for that"
- Network charges: (跟AWS很像)：
    - Ingress: free
    - Egress: 
        - charged by GBs
        - sometimes free when egress to GCP services

Security:
- 幾乎所有service都有encrytion at rest by default

GCP Organization:
- Projects: 有點像AWS accounts



References:
- Google Data Center Tour: https://www.youtube.com/watch?v=zDAYZU4A3w0
- ByondCorp: https://cloud.google.com/beyondcorp/