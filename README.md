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
Deploy the Simulated Temperature module to let D2C messages flow to the blob storage container.

```bash
az iot edge set-modules --hub-name {YourIoTHubName} --device-id {YourPreferredDeviceID} --content resources/simulated_temperature.json
az iot edge set-modules ...
```

## Observe messages

```bash
# Check logs on the device
iotedge list
iotedge logs SimulatedTemperatureSensor

# Read Avro files download from the blob storage container
java -jar avro-tools-1.9.1.jar getschema 01_2020_10_03_17_26
java -jar avro-tools-1.9.1.jar tojson 01_2020_10_03_17_26 | jq 