let Server = { provider : Text, city : Text, region : Text, country : Text
             , ipv4 : Text, ipv6 : Optional Text, active : Bool
             }

let remote = \(provider : Text) -> \(city : Text) ->\(region : Text) ->
             \(country : Text) -> \(ipv4 : Text) -> \(ipv6 : Optional Text) ->
             \(active : Bool) ->
             { ipv4 = ipv4
             , ipv6 = ipv6
             , city = city
             , region = region
             , country = country
             , provider = provider
             , active = active
             }

let docn = remote "DigitalOcean"

let vltr = remote "Vultr"

let net  = remote "Cloudflare"

in

{ Server = Server
, remote = remote
, docn = docn
, vltr = vltr
, net = net
}
