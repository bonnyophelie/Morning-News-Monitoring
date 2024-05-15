import ovh
import json

# Get OVH API credentials from environment variables
OVH_ENDPOINT = os.environ.get("OVH_ENDPOINT")
APPLICATION_KEY = os.environ.get("OVH_APPLICATION_KEY")
APPLICATION_SECRET = os.environ.get("OVH_APPLICATION_SECRET")
CONSUMER_KEY = os.environ.get("OVH_CONSUMER_KEY")

# OVH API client setup
client = ovh.Client(
    endpoint=OVH_ENDPOINT,
    application_key=APPLICATION_KEY,
    application_secret=APPLICATION_SECRET,
    consumer_key=CONSUMER_KEY
)

# Replace this with your domain name
DOMAIN_NAME = "monitoring.batch7.online"

# Get the zone ID for the specified domain
zone_id = client.get(f"/domain/zone/{DOMAIN_NAME}")

# Get DNS records for the specified domain
records = client.get(f"/domain/zone/{zone_id}/record", fieldType="A")

# Construct the inventory dictionary
inventory = {
    "all": {
        "hosts": {}
    }
}

# Populate the inventory with IP addresses from DNS records
for record in records:
    ip_address = record["target"]
    hostname = record["subDomain"] if record["subDomain"] != "@" else ""
    inventory["all"]["hosts"][ip_address] = {}
    if hostname:
        inventory["all"]["hosts"][ip_address]["ansible_hostname"] = hostname

# Print the inventory as JSON
print(json.dumps(inventory, indent=4))
