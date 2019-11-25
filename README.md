## terraform module for aws transfer server 

AWS transfer server for sftp is fully managed SFTP service. 

It is costly in my opinion.  In most case, to save the cost, you needn't create different sftp servers for different environments (we used to do that for application deployment). 

So manage different sftp groups on same sftp server is the way using by this repository.
 
## Improvements

This repository is forked from [felipefrizzo/terraform-aws-transfer-server](https://github.com/felipefrizzo/terraform-aws-transfer-server)

I did lots of changes with below improvement:

1) upgrade to terraform 0.12+
2) remove the s3 bucket resources out of this repo. I would not recommend to manage s3 bucket with sftp service together. It has the risk to clean/delete the s3 bucket carelessly. 
3) manage different iam roles for transfer server and sftp users
4) manage sftp users and their public keys as list.
5) manage different sftp groups (optional) with different s3 bucket and its folders' permission.

## Todo:

Currently I set two groups as sample, dev and prod, both are optional. If you need add more environments, do it by yourself. 

## Manual tasks

1) Make sure you have created the s3 buckets for this aws transfer sftp server.
1) update default value of project name, user name, user public keys in `variables.tf` or feed as variables
2) update iam role permission in folder `tempaltes`

## Examples

Examples are in folder [examples](examples)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| application | application name | string | `"sftp"` | no |
| project | project name | string | `"my-project"` | no |
| s3\_bucket\_dev | s3 bucket name for dev | string | `""` | no |
| s3\_bucket\_prod | s3 bucket name for prod | string | `""` | no |
| transfer\_server\_ssh\_key\_dev | SSH publish key for transfer server user | list(string) | `[]` | no |
| transfer\_server\_ssh\_key\_prod | SSH publish key for transfer server user | list(string) | `[]` | no |
| transfer\_server\_user\_name\_dev | User name for SFTP server | list(string) | `[]` | no |
| transfer\_server\_user\_name\_prod | User name for SFTP server | list(string) | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| transfer\_server\_endpoint |  |
| transfer\_server\_id |  |
