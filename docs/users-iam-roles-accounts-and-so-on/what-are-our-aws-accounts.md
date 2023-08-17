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

Another old account; contents unknown.

The root email address for this account is <s.strategy@wellcome.org>, which is a shared inbox.

## Closed accounts

For historical reference, these are accounts we used to have but have since closed:

* 	**241906670800 / dam_prototype** – used for testing a prototype of the storage service (dam as in DAMS, short for Digital Asset Management System, which is a bit of jargon from the cultural heritage sector)

* 	**656287925160** – used for some early Digital Platform testing and as the root of a Wellcome Collection-specific AWS Organization.
	All our accounts were later moved into the Wellcome Trust Organization, so this account was closed.
    Our accounts are now in the Wellcome Trust Organization, so this account was unused.

*	**353326981479** – another now-closed account used for early platform testing.
