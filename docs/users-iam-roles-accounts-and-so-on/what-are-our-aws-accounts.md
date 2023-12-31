# What are our AWS accounts?

We split our resources into a number of different AWS accounts, to provide a degree of isolation between unrelated services.

These accounts are managed under an [AWS Organization] owned by Wellcome.
This page lists all of the Wellcome Collection accounts, and there's a list of all of Wellcome's accounts [in Confluence][confluence].

[AWS Organization]: https://docs.aws.amazon.com/organizations/latest/userguide/orgs_introduction.html
[confluence]: https://wellcometrust.atlassian.net/wiki/spaces/INF/pages/719618052/AWS+Account+List

## Active accounts

### 760097843905 / platform

This is our original AWS account.

This is meant to be used for infrastructure which is shared across the platform, but it also contains some resources that predate our use of multiple accounts (e.g. our CI infrastructure, shared IAM roles).
Ideally we'd like to put those resources into dedicated accounts, but moving resources between accounts is complicated!

### 756629837203 / catalogue

Everything for the catalogue API, including both the API itself and some data pipelines.

The catalogue pipeline doesn't run in this account; it still runs in the platform account.
Ideally it would run here, but it's a big job to move it.

### 964279923020 / data

Data science services.

This has mostly been used for prototyping and experiments, not any public-facing or permanent infrastructure.

### 653428163053 / digirati

Everything managed by Digirati, including DLCS and iiif-builder.

### 404315009621 / digitisation

This account just has some S3 buckets used by the Digital Production team.

### 130871440101 / experience

The front-end web apps for wellcomecollection.org.

The naming is somewhat legacy – there used to be a team called "Digital Experience" that was responsible for these apps.
That team hasn't existed for a while, but the name is hard to change.

### 770700576653 / identity

Services involved in library account management.

These services all touch personally identifiable information (PII) in the form of user logins and library patron data.
This is an example of why we run services in different accounts – these services are isolated from the rest of the platform, to reduce the risk of PII accidentally leaking.

### 269807742353 / reporting

Services for populating the reporting cluster, which we use for in-house data analytics, dashboards, and so on.

### 975596993436 / storage

The [storage service], which houses the permanent digital collections.

This account includes both the S3 buckets that are the permanent storage, and the services that populate them.

[storage service]: https://github.com/wellcomecollection/storage-service

### 299497370133 / workflow

Goobi and Archivematica.
These are sometimes referred to as "workflow" systems, hence the account name.

## Dormant accounts

There are a couple of accounts that predate the current platform team.
These accounts still exist and have some resources in them, but we might want to clean them up at some point.

Although they predate the platform, they do have our standard set of IAM roles for easy access.

### 782179017633 / microsites

An account with some old Wellcome Collection microsites.

### 487094370410 / systems_strategy

Another old account, used for mostly-deprecated services.
The only thing left in this account is the old Medical Officer of Health (MOH) reports.

There's a [GitHub ticket](https://github.com/wellcomecollection/platform/issues/5669) that's tracking the gradual deletion of resources in this account.

The root email address for this account is <s.strategy@wellcome.org>, which is a shared inbox.

## Other AWS accounts

### 267269328833 / Wellcome DNS

This account is owned by Wellcome Trust rather than Wellcome Collection, and it's where all the DNS records are managed.
We can get access to this account from the platform-superdev initial role by assuming the following role:

```
arn:aws:iam::267269328833:role/wellcomecollection-assume_role_hosted_zone_update
```

and then you can see the DNS records in Route 53 for:

*   wellcomecollection.org ([Route 53 console](https://console.aws.amazon.com/route53/v2/hostedzones#ListRecordSets/Z0902614YH73JBCZG1MA))
*   wellcomeimages.org ([Route 53 console](https://us-east-1.console.aws.amazon.com/route53/v2/hostedzones#ListRecordSets/Z3TXBL5I2YRXXX), [our Terraform config](https://github.com/wellcomecollection/wellcomeimages.org/tree/1ea58180a40e79e98940cd78cede5571c547a3d7))
*   wellcomelibrary.org ([Route 53 console](https://console.aws.amazon.com/route53/v2/hostedzones?#ListRecordSets/Z78J6G8RSOLSZ), [our Terraform config](https://github.com/wellcomecollection/wellcomelibrary.org/tree/69f6e3b669cdc519ae44f4a3e11a93a4d0fb3cc5))*

(You can't find the hosted zone in the Route 53 console because we don't have the ListHostedZones permission – some of them are for domains we don't control.)

## Closed accounts

For historical reference, these are accounts we used to have but have since closed:

* 	**241906670800 / dam_prototype** – used for testing a prototype of the storage service (dam as in DAMS, short for Digital Asset Management System, which is a bit of jargon from the cultural heritage sector)

* 	**656287925160** – used for some early Digital Platform testing and as the root of a Wellcome Collection-specific AWS Organization.
	All our accounts were later moved into the Wellcome Trust Organization, so this account was closed.
    Our accounts are now in the Wellcome Trust Organization, so this account was unused.

*	**353326981479** – another now-closed account used for early platform testing.
