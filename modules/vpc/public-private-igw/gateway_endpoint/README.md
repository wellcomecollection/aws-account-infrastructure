# gateway_endpoint

This module creates a [Gateway VPC endpoint][gateway].

This allows services in a private subnet to access Amazon S3 and DynamoDB without going through the NAT Gateway (which incurs a bandwidth charge).
These endpoints are free to create, so we create them in all our VPCs to avoid unnecessary charges.

[gateway]: https://docs.aws.amazon.com/vpc/latest/privatelink/gateway-endpoints.html
