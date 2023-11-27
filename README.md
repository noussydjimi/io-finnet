# io-finnet

## terraform ##
<p>
Terraform use a customizable backend that can be use to serve different envirnment.
</p>

**terraform init:**
<p>
terraform init --backend-config=environments/{ENV}/backend-config -var-file environments/{ENV}/terraform.tfvars
</p>

**terraform plan:**
<p>
terraform plan -var-file environments/{ENV}/terraform.tfvars
</p>


## Ansible ##
<p>
In this example Ansible is using a dynamic inventory to automatically create hosts group base on AWS ec2 instance tag.
</p>
