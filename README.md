# *iothub* - getting started

## Create Azure iothub resource 

```bash
terraform init -input=false
terraform plan -out=tfplan -input=false
terraform apply -input=false tfplan
```

Take note of output values for ```iothubname``` and ```iothubowner_connection_string``` 

## Provision IoT devices

Create an *edge-enabled* device identity

```bash
az iot hub device-identity create --hub-name {YourIoTHubName} --device-id {YourPreferredDeviceID} --edge-enabled 
az iot hub device-identity connection-string show --hub-name {YourIoTHubName} --device-id {YourPreferredDeviceID} | jq .connectionString
```

## Deploy a marketplace module
az iot h

```bash
az iot edge set-modules ...
```