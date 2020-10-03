# *iothub* - getting started

## Create Azure iothub resource 

```bash
terraform init -input=false
terraform plan -out=tfplan -input=false
terraform apply -input=false tfplan
```

Record output values for ```iothubname```

## Provision IoT devices

Create an *edge-enabled* device identity

```bash
az iot hub device-identity create --hub-name {YourIoTHubName} --device-id {YourPreferredDeviceID} --edge-enabled 
az iot hub device-identity connection-string show --hub-name {YourIoTHubName} --device-id {YourPreferredDeviceID} | jq .connectionString
```
