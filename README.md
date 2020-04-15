# crashcourse_team5

```
	sudo apt-get update -y && sudo apt-get upgrade -y
	sudo apt-get install unzip -y
	wget https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_linux_amd64.zip
	unzip terraform_0.12.24_linux_amd64.zip
	sudo mv terraform /usr/local/bin/

	terraform --version

	curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```
```
In Azure CLI
	// створити суб'єкт-службу, виведе APP_ID, PASSWORD, TENANT_ID
	SUBSCRIPTION_ID='YOUR_SUBSCRIPTION_ID'
	az account set --subscription="${SUBSCRIPTION_ID}"
	az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/${SUBSCRIPTION_ID}"
```
```
	az login --service-principal --username APP_ID --password PASSWORD --tenant TENANT_ID
```