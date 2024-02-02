# VNS3 NATe

Terraform implementation of Cohesive Networks [VNS3 NATe][1] running on AWS.

<img src=".assets/vns3.png" />

The image is ready for use in the [AWS Marketplace][2]. A [free option][3] is also available with limited instances and throughput. Additional articles can be found for [getting started][4], [cloud setup][5], and [AWS features][6].

## Deploy

Create a copy to the `.auto.tfvars` template to fine tune your deployment:

```sh
cp config/templates.tfvars .auto.tfvars
```

Create the resources:

```sh
terraform init
terraform apply -auto-approve
```

The Web UI administration URL will be part of the output.

Connect to the admin panel:

```
https://<instance-public-ip>:8000
```

Credentials

- Username: vnscubed
- Password: The instance ID (E.g.: i-012fsd8a9fsd823cv)


To test connections from the the private server, use SSM:

```sh
aws ssm start-session --target <instance>
```


[1]: https://docs.cohesive.net/docs/nate/
[2]: https://aws.amazon.com/marketplace/pp/prodview-beu27g23xt4ok
[3]: https://aws.amazon.com/marketplace/pp/prodview-wf7yma4f6mdw4
[4]: https://docs.cohesive.net/tutorials/getting-started/
[5]: https://docs.cohesive.net/docs/cloud-setup/aws/
[6]: https://docs.cohesive.net/docs/vns3/aws-features/
