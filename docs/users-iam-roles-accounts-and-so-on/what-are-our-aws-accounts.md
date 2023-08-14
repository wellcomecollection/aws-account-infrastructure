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

## 964279923020 / data

Data science services.

This has mostly been used for prototyping and experiments, not any public-facing or permanent infrastructure.

## 653428163053 / digirati

Everything managed by Digirati, including DLCS and iiif-builder.

## 404315009621 / digitisation

This account just has some S3 buckets used by the Digital Production team.

## 130871440101 / experience

The front-end web apps for wellcomecollection.org.

The naming is somewhat legacy – there used to be a team called "Digital Experience" that was responsible for these apps.
That team hasn't existed for a while, but the name is hard to change.

## 770700576653 / identity

Services involved in library account management.

These services all touch personally identifiable information (PII) in the form of user logins and library patron data.
This is an example of why we run services in different accounts – these services are isolated from the rest of the platform, to reduce the risk of PII accidentally leaking.

## 269807742353 / reporting

Services for populating the reporting cluster, which we use for in-house data analytics, dashboards, and so on.

## 975596993436 / storage

The [storage service], which houses the permanent digital collections.

This account includes both the S3 buckets that are the permanent storage, and the services that populate them.

[storage service]: https://github.com/wellcomecollection/storage-service

## 299497370133 / workflow

Goobi and Archivematica.

## Dormant accounts

There are a couple of accounts that predate

  <tr>
    <td>reporting</td>
    <td>269807742353</td>
    <td>
      Services for populating the reporting cluster.
    </td>
  </tr>
  <tr>
    <td>storage</td>
    <td>975596993436</td>
    <td>
      The storage service, including both the permanent S3 buckets and the transient services.
    </td>
  </tr>
  <tr>
    <td>workflow</td>
    <td>299497370133</td>
    <td>Goobi and Archivematica.</td>
  </tr>
  <tr>
    <td>microsites</td>
    <td>782179017633</td>
    <td>
      An old account with some microsites.
      This predates the platform.
      See <a href="./docs/microsites.md">notes on the microsites account</a>.
    </td>
  </tr>
  <tr>
    <td>systems_strategy</td>
    <td>487094370410</td>
    <td>
      Another old account.
      This predates the platform.
    </td>
  </tr>

</table>

For historical reference, these are accounts we used to have but have since closed:

<table>
  <tr>
    <td>dam_prototype</td>
    <td>241906670800</td>
    <td>
      Used for testing the storage service demo.
    </td>
  </tr>
  <tr>
    <td>—</td>
    <td>656287925160</td>
    <td>
      Used for very early Digital Platform testing and as the root of a Wellcome Collection-specific AWS Organization.
      Our accounts are now in the Wellcome Trust Organization, so this account was unused.
    </td>
  </tr>
</table>

There's a list of all of Wellcome's AWS account in the [Wellcome Trust Confluence](https://wellcometrust.atlassian.net/wiki/spaces/INF/pages/719618052/AWS+Account+List).
