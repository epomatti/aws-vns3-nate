# VNS3 NATe

Cohesive Networks VNS3 NATe running on AWS.

This project is based on `6.1.3-20230925`.

If you want to control

```sh
cp config/templates.tfvars .auto.tfvars
```

Create the SSH key pair to be associated with the VNS3 EC2 instance:

```sh
mkdir keys && ssh-keygen -f keys/vns3
```

Create the resources:

```sh
terraform init
terraform apply -auto-approve
```

"https://<instance-public-ip>:8000"

- Username: vnscubed
- Password: i-000d15ffc5c7d9370
