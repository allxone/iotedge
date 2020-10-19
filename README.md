# *iothub* - getting started

## Create Azure iothub resource 

```bash
terraform init -input=false
terraform plan -out=tfplan -input=false
terraform apply -input=false tfplan
```

The ```iothubname``` output will be used to create device identity.

The ```iothubowner_connection_string``` output will be used in /etc/iotedge/config.yaml on the device running the IoT Edge Runtime.


## Provision IoT devices

Create an *edge-enabled* device identity

```bash
az iot hub device-identity create --hub-name {YourIoTHubName} --device-id {YourPreferredDeviceID} --edge-enabled 
az iot hub device-identity connection-string show --hub-name {YourIoTHubName} --device-id {YourPreferredDeviceID} | jq .connectionString

# Example
export hub=$(terraform output -json | jq -r .iothub_name.value)
export device="mydevice"
az iot hub device-identity create --hub-name $hub --device-id $device --edge-enabled 
az iot hub device-identity show-connection-string --hub-name $hub --device-id $device | jq .connectionString

```


## Deploy a marketplace module

Deploy the Simulated Temperature module to let D2C messages flow to the blob storage container.

```bash
az iot edge set-modules --hub-name {YourIoTHubName} --device-id {YourPreferredDeviceID} --content resources/simulated_temperature.json
```


## Read messages
The on prem SimulatedTemperatureSensor IoT Edge module delivers messages to the cloud-deployed IoT Hub via the edgeHub proxy.
The Iot Hub stores messages into the blob storage endpoint in Avro format.  

```bash
# Check logs on the device
iotedge list
iotedge logs SimulatedTemperatureSensor

# Read Avro files downloaded from the blob storage container
java -jar avro-tools-1.9.1.jar getschema 01_2020_10_03_17_26
java -jar avro-tools-1.9.1.jar tojson 01_2020_10_03_17_26 | jq
```

## Develop locally

```bash
export hub=$(terraform output -json | jq -r .iothub_name.value)
export device="simulator"
az iot hub device-identity create --hub-name $hub --device-id $device --edge-enabled 
export connectionstring=$(az iot hub device-identity show-connection-string --hub-name $hub --device-id $device | jq .connectionString)
sudo iotedgehubdev setup -c $connectionstring
```