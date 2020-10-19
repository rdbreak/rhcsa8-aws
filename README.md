# RHCSA 8 Automated Practice Deployment
_Powered by Packer, Terraform, and Ansible_ 

## Important Prerequisites:
1. A free AWS (Amazon Web Services) account is needed to use this environment.
2. Once you create your AWS account, create a new IAM User (Ex. RedHatUser) with Admin privileges 
3. Create a role with Admin access policy for the EC2 instances (Ex. rhcsa8env-role)
4. Download the key pair file (ending in .pem) and save it to your home directory.
5. Use the awscli to add the credentials for the IAM user you created in step 2 (using aws configure).

## Resources Created by Terraform (resources may cost money)
- 1 VPC
- 1 NAT Gatways
- 1 Route Tables
- 1 Private Subnets
- 1 Public Subnets
- 1 Elastic IP
- 1 Security Group
- 2 EC2 Instances

## Installation options below:
## macOS
##### Install all at once with the command below:
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" && xcode-select --install &&brew install ansible ; brew install python ; brew install terraform ; brew install packer ; brew install awscli
```

##### Once the above software is installed. Do the following if you're running the environment on Mac:
1. Create a separate `~/bin` directory and `cd` to it.  (The directory doesn't have to be ~/bin, it can be anything you want.)
2. Clone the environment repo to it with `git clone https://github.com/rdbreak/aws/rhcsa8-aws.git`
3. Change to the `aws/rhcsa8-aws` directory that is now in your `~/bin` directory.
4. Run `terraform init` to initialize the environment
5. Run `terraform apply` to deploy the environment

## CentOS/RHEL/Manjaro/Arch - Install all at once by Copy/Pasting the below command into your terminal as root.
_NOTE - If it's been awhile since you've run yum update, do that first. Reboot if the kernel was updated. There may be some dependencies errors but don't be alarmed as this won't stop the environment from working._

##### For Linux
##### Depending if you have Python 2 or 3, use pip and pip3, respectively.
`pip3 install ansible packer terraform awscli`

##### Once the above software is installed. Do the following if you're running the environment on Linux:
1. Create a separate `~/bin` directory and `cd` to it.  (The directory doesn't have to be ~/bin, it can be anything you want.)
2. Clone the environment repo to it with `git clone https://github.com/rdbreak/aws/rhcsa8-aws.git`
3. Change to the `rhcsa8-aws` directory that is now in your `~/bin` directory.
4. Run `terraform init` to initialize the environment
5. Run `terraform apply` to deploy the environment

##### When Terraform is finished building out the environment, it will output the public IPs for the server1 and 2. Use the below command to access the servers:
`ssh -i "~/rhcsa8env.pem" centos@<public IP>`

## Windows
- If using Windows:
- [Install the Latest Version of Terraform](https://www.terraform.io/downloads.html)
- [Install the Latest Version of Packer](https://www.packer.io/downloads.html)
- [Install the Latest Version of awscli](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-windows.html)

##### Once the above software is installed. Do the following if you're running the environment on Windows:
1. Create a separate `~/bin` directory and `cd` to it using the same PowerShell/Terminal as Administrator/Root.  (The directory doesn't have to be ~/bin, it can be anything you want.)
2. Use your browser of choice and navigate to https://github.com/rdbreak/aws/rhcsa8env, press the green “Clone or download” button then the “Download ZIP” button. Or use Github Desktop (See below).
3. Once downloaded, unzip the file and move it to the directory you created earlier, `~/bin` in the above example.
4. Use PowerShell/Terminal as Administrator/Root again and cd to the `~/bin/aws/rhcsa8-aws` directory then run:
 - Run `terraform apply` to deploy the environment

_Now the deployment should be up and running!_

## (Recommended) Install Github Desktop to make pulling down changes easier
_NOTE this requires a free Github account_
1. Navigate to https://desktop.github.com/ and download Github Desktop.
2. Create or sign in to your account.
3. Click "Clone a repository from the Internet" and enter "rdbreak/aws/rhcsa8env" and choose a location then "Clone".
4. You are also able to easily pull changes when they're made available.

## Notable commands to control the environment:
- `terraform plan` - Only shows changes that will be made if `terraform apply` is run
- `terraform apply` - Provisions and deploys the resources in the environment
- `terraform destroy` - Shuts down and destroys all the resources in the environment


## Included systems:
- server1.eight.example.com
- server2.eight.example.com

## Accessing the systems
##### Once Terraform is finished provisioning, it will output the public IPs of both servers
Remember to add the IP addresses to your local host file if you want to connect to the guest systems with the hostname.
Username - centos
- For root - use `sudo` or `sudo su`
Access example - `ssh -i "~/rhcsa8env.pem" centos@<public IP of server>`

## Help
If you're having problems with the environment, please submit an issue by going to the `ISSUES` tab at the top. If you have more questions, looking for practice exams to use against this environment, or just looking for a fantastic Red Hat community to join to get your questions answered, check out the Red Hat Certs Slack Workspace. You can find the invite link at the top of this page next to the description.

## Known Issues:

