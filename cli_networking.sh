#!/bin/bash

# VPC from the awscliv2

# By default creates a VPC, RT, NACL and SG
aws ec2 create-vpc \
    --cidr-block 10.0.0.0/16 \
    --instance-tenancy default \
    --no-amazon-provided-ipv6-cidr-block \
    --tag-specifications 'ResourceType=vpc,Tags=[{Key=Name,Value=clivpc}]'


{
    "Vpcs": [
        {
            "CidrBlock": "10.0.0.0/16",
            "DhcpOptionsId": "dopt-047e63cfcd52661b1",
            "State": "available",
            "VpcId": "vpc-076b0f1d6f917162f",
            "OwnerId": "089634162715",
            "InstanceTenancy": "default",
            "CidrBlockAssociationSet": [
                {
                    "AssociationId": "vpc-cidr-assoc-0b6827898d0d836d9",
                    "CidrBlock": "10.0.0.0/16",
                    "CidrBlockState": {
                        "State": "associated"
                    }
                }
            ],
            "IsDefault": false,
            "Tags": [
                {
                    "Key": "Name",
                    "Value": "clivpc"
                }
            ]
        }
    ]
}

aws ec2 modify-vpc-attribute \
--vpc-id vpc-076b0f1d6f917162f \
--enable-dns-hostnames

aws ec2 create-tags \
--resources rtb-05af1e4616b2c0a77 acl-0a776bdbbe55ea047 sg-0d0c1d39a4462832a \
--tags Key=Name,Value=clivpc


aws ec2 create-subnet \
--vpc-id vpc-076b0f1d6f917162f \
--cidr-block 10.0.1.0/24 \
--availability-zone us-east-1a

{
    "Subnet": {
        "AvailabilityZone": "us-east-1a",
        "AvailabilityZoneId": "use1-az1",
        "AvailableIpAddressCount": 251,
        "CidrBlock": "10.0.1.0/24",
        "DefaultForAz": false,
        "MapPublicIpOnLaunch": false,
        "State": "available",
        "SubnetId": "subnet-0029d1708c220bfe2",
        "VpcId": "vpc-076b0f1d6f917162f",
        "OwnerId": "089634162715",
        "AssignIpv6AddressOnCreation": false,
        "Ipv6CidrBlockAssociationSet": [],
        "SubnetArn": "arn:aws:ec2:us-east-1:089634162715:subnet/subnet-0029d1708c220bfe2"
    }
}

aws ec2 create-tags \
--resources subnet-0029d1708c220bfe2 \
--tags Key=Name,Value=us-east-1a-pub Key=cidr,Value=10-0-1-0

aws ec2 modify-subnet-attribute \
--subnet-id subnet-0029d1708c220bfe2 \
--map-public-ip-on-launch


aws ec2 create-subnet \
--vpc-id vpc-076b0f1d6f917162f \
--cidr-block 10.0.2.0/24 \
--availability-zone us-east-1b

{
    "Subnet": {
        "AvailabilityZone": "us-east-1b",
        "AvailabilityZoneId": "use1-az2",
        "AvailableIpAddressCount": 251,
        "CidrBlock": "10.0.2.0/24",
        "DefaultForAz": false,
        "MapPublicIpOnLaunch": false,
        "State": "available",
        "SubnetId": "subnet-0cdb255d14197d8f8",
        "VpcId": "vpc-076b0f1d6f917162f",
        "OwnerId": "089634162715",
        "AssignIpv6AddressOnCreation": false,
        "Ipv6CidrBlockAssociationSet": [],
        "SubnetArn": "arn:aws:ec2:us-east-1:089634162715:subnet/subnet-0cdb255d14197d8f8"
    }
}

aws ec2 create-tags \
--resources subnet-0cdb255d14197d8f8 \
--tags Key=Name,Value=us-east-1b-priv Key=cidr,Value=10-0-2-0


aws ec2 create-internet-gateway \
--tag-specifications 'ResourceType=internet-gateway,Tags=[{Key=Name,Value=clivpcigw}]'
{
    "InternetGateway": {
        "Attachments": [],
        "InternetGatewayId": "igw-0952576dc6c9d526b",
        "OwnerId": "089634162715",
        "Tags": [
            {
                "Key": "Name",
                "Value": "clivpcigw"
            }
        ]
    }
}

aws ec2 attach-internet-gateway \
--vpc-id vpc-076b0f1d6f917162f \
--internet-gateway-id igw-0952576dc6c9d526b


aws ec2 create-route-table \
--vpc-id vpc-076b0f1d6f917162f \
--tag-specifications 'ResourceType=route-table,Tags=[{Key=Name,Value=clivpc-priv-rt}]'
{
    "RouteTable": {
        "Associations": [],
        "PropagatingVgws": [],
        "RouteTableId": "rtb-076004a9fff3c9dd4",
        "Routes": [
            {
                "DestinationCidrBlock": "10.0.0.0/16",
                "GatewayId": "local",
                "Origin": "CreateRouteTable",
                "State": "active"
            }
        ],
        "Tags": [
            {
                "Key": "Name",
                "Value": "clivpc-priv-rt"
            }
        ],
        "VpcId": "vpc-076b0f1d6f917162f",
        "OwnerId": "089634162715"
    }
}

aws ec2 associate-route-table \
--subnet-id subnet-0cdb255d14197d8f8 \
--route-table-id rtb-076004a9fff3c9dd4
{
    "AssociationId": "rtbassoc-05274a9fcea726d6b",
    "AssociationState": {
        "State": "associated"
    }
}



aws ec2 create-route-table \
--vpc-id vpc-076b0f1d6f917162f \
--tag-specifications 'ResourceType=route-table,Tags=[{Key=Name,Value=clivpc-pub-rt}]'
{
    "RouteTable": {
        "Associations": [],
        "PropagatingVgws": [],
        "RouteTableId": "rtb-0be4a49591aacc202",
        "Routes": [
            {
                "DestinationCidrBlock": "10.0.0.0/16",
                "GatewayId": "local",
                "Origin": "CreateRouteTable",
                "State": "active"
            }
        ],
        "Tags": [
            {
                "Key": "Name",
                "Value": "clivpc-pub-rt"
            }
        ],
        "VpcId": "vpc-076b0f1d6f917162f",
        "OwnerId": "089634162715"
    }
}

aws ec2 create-route \
--route-table-id rtb-0be4a49591aacc202 \
--destination-cidr-block 0.0.0.0/0 \
--gateway-id igw-0952576dc6c9d526b

{
    "Return": true
}


aws ec2 associate-route-table \
--subnet-id subnet-0029d1708c220bfe2 \
--route-table-id rtb-0be4a49591aacc202

{
    "AssociationId": "rtbassoc-07fd7c6516bf90cf4",
    "AssociationState": {
        "State": "associated"
    }
}


aws ec2 create-security-group \
--group-name cli-web-dmz \
--vpc-id vpc-076b0f1d6f917162f \
--tag-specifications 'ResourceType=security-group,Tags=[{Key=Name,Value=cli-web-dmz}]' \
--description "Web DMZ" 

{
    "GroupId": "sg-095e990535bd0fc48",
    "Tags": [
        {
            "Key": "Name",
            "Value": "cli-web-dmz"
        }
    ]
}


curl https://checkip.amazonaws.com
114.34.91.127


aws ec2 authorize-security-group-ingress \
--group-id sg-095e990535bd0fc48 \
--protocol tcp \
--port 22 \
--cidr 114.34.91.0/24

aws ec2 authorize-security-group-ingress \
--group-id sg-095e990535bd0fc48 \
--protocol tcp \
--port 22 \
--cidr 114.34.91.0/24


aws ec2 run-instances \
--image-id ami-0ab4d1e9cf9a1215a \
--count 1 --instance-type t3.micro \
--key-name MarioWeb \
--security-group-ids sg-095e990535bd0fc48 \
--subnet-id subnet-0029d1708c220bfe2 \
--associate-public-ip-address \
--tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=clivpc-web01}]'

{
    "Groups": [],
    "Instances": [
        {
            "AmiLaunchIndex": 0,
            "ImageId": "ami-0ab4d1e9cf9a1215a",
            "InstanceId": "i-09c0a75a370bdaf80",
            "InstanceType": "t3.micro",
            "KeyName": "MarioWeb",
            "LaunchTime": "2021-07-03T07:26:24+00:00",
            "Monitoring": {
                "State": "disabled"
            },
            "Placement": {
                "AvailabilityZone": "us-east-1a",
                "GroupName": "",
                "Tenancy": "default"
            },
            "PrivateDnsName": "ip-10-0-1-52.ec2.internal",
            "PrivateIpAddress": "10.0.1.52",
            "ProductCodes": [],
            "PublicDnsName": "",
            "State": {
                "Code": 0,
                "Name": "pending"
            },
            "StateTransitionReason": "",
            "SubnetId": "subnet-0029d1708c220bfe2",
            "VpcId": "vpc-076b0f1d6f917162f",
            "Architecture": "x86_64",
            "BlockDeviceMappings": [],
            "ClientToken": "e36c9058-0bbc-412a-a72d-1f59924c2aad",
            "EbsOptimized": false,
            "EnaSupport": true,
            "Hypervisor": "xen",
            "NetworkInterfaces": [
                {
                    "Attachment": {
                        "AttachTime": "2021-07-03T07:26:24+00:00",
                        "AttachmentId": "eni-attach-09fad50e1994446f3",
                        "DeleteOnTermination": true,
                        "DeviceIndex": 0,
                        "Status": "attaching"
                    },
                    "Description": "",
                    "Groups": [
                        {
                            "GroupName": "cli-web-dmz",
                            "GroupId": "sg-095e990535bd0fc48"
                        }
                    ],
                    "Ipv6Addresses": [],
                    "MacAddress": "02:d5:f8:c1:c8:b9",
                    "NetworkInterfaceId": "eni-04cca9babb3b369e4",
                    "OwnerId": "089634162715",
                    "PrivateIpAddress": "10.0.1.52",
                    "PrivateIpAddresses": [
                        {
                            "Primary": true,
                            "PrivateIpAddress": "10.0.1.52"
                        }
                    ],
                    "SourceDestCheck": true,
                    "Status": "in-use",
                    "SubnetId": "subnet-0029d1708c220bfe2",
                    "VpcId": "vpc-076b0f1d6f917162f",
                    "InterfaceType": "interface"
                }
            ],
            "RootDeviceName": "/dev/xvda",
            "RootDeviceType": "ebs",
            "SecurityGroups": [
                {
                    "GroupName": "cli-web-dmz",
                    "GroupId": "sg-095e990535bd0fc48"
                }
            ],
            "SourceDestCheck": true,
            "StateReason": {
                "Code": "pending",
                "Message": "pending"
            },
            "Tags": [
                {
                    "Key": "Name",
                    "Value": "clivpc-web01"
                }
            ],
            "VirtualizationType": "hvm",
            "CpuOptions": {
                "CoreCount": 1,
                "ThreadsPerCore": 2
            },
            "CapacityReservationSpecification": {
                "CapacityReservationPreference": "open"
            },
            "MetadataOptions": {
                "State": "pending",
                "HttpTokens": "optional",
                "HttpPutResponseHopLimit": 1,
                "HttpEndpoint": "enabled"
            }
        }
    ],
    "OwnerId": "089634162715",
    "ReservationId": "r-0c27f0381388148cc"
}


aws ec2 create-security-group \
--group-name cli-priv-db-tier \
--vpc-id vpc-076b0f1d6f917162f \
--tag-specifications 'ResourceType=security-group,Tags=[{Key=Name,Value=cli-priv-db-tier}]' \
--description "Private DB SG" 

{
    "GroupId": "sg-040fb712f61583f40",
    "Tags": [
        {
            "Key": "Name",
            "Value": "cli-priv-db-tier"
        }
    ]
}

aws ec2 run-instances \
--image-id ami-0ab4d1e9cf9a1215a \
--count 1 --instance-type t3.micro \
--key-name MarioWeb \
--security-group-ids sg-040fb712f61583f40 \
--subnet-id subnet-0cdb255d14197d8f8 \
--tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=clivpc-db01}]' 

{
    "Groups": [],
    "Instances": [
        {
            "AmiLaunchIndex": 0,
            "ImageId": "ami-0ab4d1e9cf9a1215a",
            "InstanceId": "i-0257f2e93fc10a136",
            "InstanceType": "t3.micro",
            "KeyName": "MarioWeb",
            "LaunchTime": "2021-07-03T09:16:40+00:00",
            "Monitoring": {
                "State": "disabled"
            },
            "Placement": {
                "AvailabilityZone": "us-east-1b",
                "GroupName": "",
                "Tenancy": "default"
            },
            "PrivateDnsName": "ip-10-0-2-134.ec2.internal",
            "PrivateIpAddress": "10.0.2.134",
            "ProductCodes": [],
            "PublicDnsName": "",
            "State": {
                "Code": 0,
                "Name": "pending"
            },
            "StateTransitionReason": "",
            "SubnetId": "subnet-0cdb255d14197d8f8",
            "VpcId": "vpc-076b0f1d6f917162f",
            "Architecture": "x86_64",
            "BlockDeviceMappings": [],
            "ClientToken": "381797a5-f4b6-485c-adba-a2f5a52a91c6",
            "EbsOptimized": false,
            "EnaSupport": true,
            "Hypervisor": "xen",
            "NetworkInterfaces": [
                {
                    "Attachment": {
                        "AttachTime": "2021-07-03T09:16:40+00:00",
                        "AttachmentId": "eni-attach-0c841a1709f658bb4",
                        "DeleteOnTermination": true,
                        "DeviceIndex": 0,
                        "Status": "attaching"
                    },
                    "Description": "",
                    "Groups": [
                        {
                            "GroupName": "cli-priv-db-tier",
                            "GroupId": "sg-040fb712f61583f40"
                        }
                    ],
                    "Ipv6Addresses": [],
                    "MacAddress": "12:71:e8:50:7e:03",
                    "NetworkInterfaceId": "eni-0a34cd279541eb569",
                    "OwnerId": "089634162715",
                    "PrivateDnsName": "ip-10-0-2-134.ec2.internal",
                    "PrivateIpAddress": "10.0.2.134",
                    "PrivateIpAddresses": [
                        {
                            "Primary": true,
                            "PrivateDnsName": "ip-10-0-2-134.ec2.internal",
                            "PrivateIpAddress": "10.0.2.134"
                        }
                    ],
                    "SourceDestCheck": true,
                    "Status": "in-use",
                    "SubnetId": "subnet-0cdb255d14197d8f8",
                    "VpcId": "vpc-076b0f1d6f917162f",
                    "InterfaceType": "interface"
                }
            ],
            "RootDeviceName": "/dev/xvda",
            "RootDeviceType": "ebs",
            "SecurityGroups": [
                {
                    "GroupName": "cli-priv-db-tier",
                    "GroupId": "sg-040fb712f61583f40"
                }
            ],
            "SourceDestCheck": true,
            "StateReason": {
                "Code": "pending",
                "Message": "pending"
            },
            "Tags": [
                {
                    "Key": "Name",
                    "Value": "clivpc-db01"
                }
            ],
            "VirtualizationType": "hvm",
            "CpuOptions": {
                "CoreCount": 1,
                "ThreadsPerCore": 2
            },
            "CapacityReservationSpecification": {
                "CapacityReservationPreference": "open"
            },
            "MetadataOptions": {
                "State": "pending",
                "HttpTokens": "optional",
                "HttpPutResponseHopLimit": 1,
                "HttpEndpoint": "enabled"
            }
        }
    ],
    "OwnerId": "089634162715",
    "ReservationId": "r-03ce1308220b31168"
}


# You have to specify the SG ids, not names, when not using the default VPC
aws ec2 authorize-security-group-ingress \
--group-id sg-040fb712f61583f40 \
--protocol tcp --port 22 \
--source-group sg-095e990535bd0fc48

aws ec2 authorize-security-group-ingress \
--group-id sg-040fb712f61583f40 \
--protocol tcp --port 80 \
--source-group sg-095e990535bd0fc48

aws ec2 authorize-security-group-ingress \
--group-id sg-040fb712f61583f40 \
--protocol tcp --port 443 \
--source-group sg-095e990535bd0fc48

aws ec2 authorize-security-group-ingress \
--group-id sg-040fb712f61583f40 \
--protocol tcp --port 3306 \
--source-group sg-095e990535bd0fc48

aws ec2 authorize-security-group-ingress \
--group-id sg-040fb712f61583f40 \
--ip-permissions IpProtocol=icmp,FromPort=-1,ToPort=-1,IpRanges=[{CidrIp=10.0.1.0/24}]


aws ec2 allocate-address

{
    "PublicIp": "23.21.27.202",
    "AllocationId": "eipalloc-0bd27c2efde8391f1",
    "PublicIpv4Pool": "amazon",
    "NetworkBorderGroup": "us-east-1",
    "Domain": "vpc"
}

aws ec2 create-tags \
--resources eipalloc-0bd27c2efde8391f1 \
--tags Key=Name,Value=clivpc-eip


aws ec2 create-nat-gateway \
--subnet-id subnet-0029d1708c220bfe2 \
--allocation-id eipalloc-0bd27c2efde8391f1

{
    "ClientToken": "44696517-4e9b-494d-a412-e3ae3332501b",
    "NatGateway": {
        "CreateTime": "2021-07-03T12:24:16+00:00",
        "NatGatewayAddresses": [
            {
                "AllocationId": "eipalloc-0bd27c2efde8391f1"
            }
        ],
        "NatGatewayId": "nat-025f575de77e19e37",
        "State": "pending",
        "SubnetId": "subnet-0029d1708c220bfe2",
        "VpcId": "vpc-076b0f1d6f917162f"
    }
}

ubuntulab:network$ aws ec2 create-route \
--route-table-id rtb-076004a9fff3c9dd4 \
--destination-cidr-block 0.0.0.0/0 \
--nat-gateway-id nat-025f575de77e19e37

{
    "Return": true
}



aws ec2 create-network-acl \
--vpc-id vpc-076b0f1d6f917162f \
--tag-specifications 'ResourceType=network-acl,Tags=[{Key=Name,Value=clivpc-nacl}]'

{
    "NetworkAcl": {
        "Associations": [],
        "Entries": [
            {
                "CidrBlock": "0.0.0.0/0",
                "Egress": true,
                "IcmpTypeCode": {},
                "PortRange": {},
                "Protocol": "-1",
                "RuleAction": "deny",
                "RuleNumber": 32767
            },
            {
                "CidrBlock": "0.0.0.0/0",
                "Egress": false,
                "IcmpTypeCode": {},
                "PortRange": {},
                "Protocol": "-1",
                "RuleAction": "deny",
                "RuleNumber": 32767
            }
        ],
        "IsDefault": false,
        "NetworkAclId": "acl-01cbf9c9c60a60e33",
        "Tags": [
            {
                "Key": "Name",
                "Value": "clivpc-nacl"
            }
        ],
        "VpcId": "vpc-076b0f1d6f917162f",
        "OwnerId": "089634162715"
    }
}

# Could not find association-id in the management console
aws ec2 replace-network-acl-association \
--association-id aclassoc-66a84344 \
--network-a acl-01cbf9c9c60a60e33

{
    "NewAssociationId": "aclassoc-00d07794e064ba02e"
}



aws ec2 create-network-acl-entry \
--network-acl-id acl-01cbf9c9c60a60e33 \
--rule-number 100 --protocol tcp \
--port-range From=80,To=80 \
--cidr-block 0.0.0.0/0 \
--rule-action allow --ingress 

aws ec2 create-network-acl-entry \
--network-acl-id acl-01cbf9c9c60a60e33 \
--rule-number 200 --protocol tcp \
--port-range From=443,To=443 \
--cidr-block 0.0.0.0/0 \
--rule-action allow --ingress 

aws ec2 create-network-acl-entry \
--network-acl-id acl-01cbf9c9c60a60e33 \
--rule-number 300 --protocol tcp \
--port-range From=22,To=22 \
--cidr-block 0.0.0.0/0 \
--rule-action allow --ingress 

aws ec2 create-network-acl-entry \
--network-acl-id acl-01cbf9c9c60a60e33 \
--rule-number 400 --protocol tcp \
--port-range From=1024,To=65535 \
--cidr-block 0.0.0.0/0 \
--rule-action allow --ingress

aws ec2 create-network-acl-entry \
--network-acl-id acl-01cbf9c9c60a60e33 \
--rule-number 100 --protocol tcp \
--port-range From=80,To=80 \
--cidr-block 0.0.0.0/0 \
--rule-action allow --egress

aws ec2 create-network-acl-entry \
--network-acl-id acl-01cbf9c9c60a60e33 \
--rule-number 200 --protocol tcp \
--port-range From=443,To=443 \
--cidr-block 0.0.0.0/0 \
--rule-action allow --egress

aws ec2 create-network-acl-entry \
--network-acl-id acl-01cbf9c9c60a60e33 \
--rule-number 300 --protocol tcp \
--port-range From=1024,To=65535 \
--cidr-block 0.0.0.0/0 \
--rule-action allow --egress

aws ec2 create-network-acl-entry \
--network-acl-id acl-01cbf9c9c60a60e33 \
--rule-number 400 --protocol tcp \
--port-range From=22,To=22 \
--cidr-block 0.0.0.0/0 \
--rule-action allow --egress













