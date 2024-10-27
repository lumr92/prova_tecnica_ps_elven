provider "HTTP" {}

data "http" "ip" {

  url = "https://ipinfo.io/ip"
}

output "show_ip" {
  value = data.http.ip
}