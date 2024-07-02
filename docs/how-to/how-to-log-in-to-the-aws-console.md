# How to log in to the AWS console

1.  Visit <https://myapps.microsoft.com/>.
    Log in using your `c_` account, e.g. `c_chana@wellcome.ac.uk`.

2.  You should see a list of apps.
    Select the app named "AWS - IAM Identity Center".

    If you can't see that app, it means you don't have access to our AWS accounts.
    Talk to a/another developer.

    <img src="./wellcomecloud-screenshot.png" alt="The AWS IAM identity center app on the my apps dashboard.">

3.  You should be taken to the AWS IAM Identity center login page.
    Select the account called "Digital Engagement Platform", and the "Platform-Dev" role.

    <img src="./aws-identity-center.png" alt="Screenshot of the IAM Identity Center page, the Digital Engagement platform account is visible">

4.  You should be taken to the AWS console.

    <img src="./aws-console.png" alt="Screenshot of the AWS Management Console homepage. There's a top menu bar, a list of services, and a footer.">

5.  Your default role can't do anything; it can only assume specific roles in other accounts.
    To assume a role, click the menu in the top right-hand corner, and click "Switch Role".

    <img src="./assume-role-menu.png" alt="The same homepage as previously, but now with a dropdown menu coming from the top right-hand corner. At the bottom are two buttons: 'Switch role' and 'Sign out'.">

6.  You should be taken to a "Switch Role" screen.
    Enter the account ID and name of the role you want to assume, then click "Switch Role".

    <img src="./assume-role-switcher.png" alt="A 'Switch Role' form with three fields: Account, Role, and Display Name. There's also a colour picker and a 'Switch Role' button.">

Some developers use the [AWS Extend Switch Roles extension][ext] in Google Chrome, which adds a list of all our roles to the top right-hand menu.
We have a [config file] you can use with the extension.

[ext]: https://chrome.google.com/webstore/detail/aws-extend-switch-roles/jpmkfafbacpgapdghgdpembnojdlgkdl
[config file]: https://github.com/wellcomecollection/aws-account-infrastructure/blob/main/accounts/chrome_extension_config.ini
