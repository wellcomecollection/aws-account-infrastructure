# What is an initial role?

An **initial role** is the first IAM role that users assume when they log into our AWS estate.

```mermaid
flowchart LR
    L[User logs in<br/>through Azure AD] --> IR[User assumes<br/>an <strong>initial role</strong>]
    IR --> SR[User assumes a<br/>more specific role]
    SR --> DS[User can do stuff<br/>inside AWS]

    classDef externalNode fill:#e8e8e8,stroke:#8f8f8f
    class L,SR,DS externalNode

    classDef initialRole fill:#ffebad,stroke:#ffce3c,stroke-width:2px
    class IR initialRole
```

This initial role can't do anything except assume a more specific IAM role.
It's a "stepping stone" into AWS.

## Which initial role do you use?

The initial roles are handled by [User Groups in the Azure AD application][users_and_groups] for the Platform AWS account.

![A table of groups in the Azure AD console. Each group has a name (for example, 'RG_WC_Digirati_Developer') and a list of roles assigned (for example, 'digirati-dev, azure_sso-saml_provider').](group_screenshot.png)

Everybody who can log into our AWS estate is a member of at least one of these groups.
Each group has two roles assigned:

*   The `azure_sso-saml_provider` role
*   An initial role, for example `digirati-dev` or `data-analyst`

When you log in to AWS, your initial role is determined by the role assigned to each of the groups that you're in.

[users_and_groups]: https://portal.azure.com/#view/Microsoft_AAD_IAM/ManagedAppMenuBlade/~/Users/objectId/c300392b-56aa-4a3e-8d2c-249ce2d5468d/appId/3bfb9ee4-2ec9-40e0-8432-10cd46f9afe4

## Examples

1.  Suppose you're a member of the `RG_WC_Digital_Data_Analyst` group.
    The initial role assigned to this group is `data-analyst`.

    There is only one choice of role, so when you log in to AWS, you're logged in using the `data-analyst` role.

2.  Suppose you're a member of the `RC_WC_Digital_Platform_Developer` and `RC_WC_Digital_Workflow_Developer` groups.
    The initial roles assigned to these groups are `platform-dev` and `workflow-dev`.

    When you log in to AWS, you'll be offered a choice between these two roles.
