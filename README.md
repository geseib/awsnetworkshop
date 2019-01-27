# aws-workshop-sample

This project allows you to scaffold a workshop similar to those available at [cdkworkshop.com](https://cdkworkshop.com/), [eksworkshop.com](https://eksworkshop.com/), or [ecsworkshop.com](https://ecsworkshop.com/).

```bash
.
├── buildspec.yml                     <-- Build Spec used to build this project in CodeBuild
├── LICENSE.txt                       <-- License file
├── README.md                         <-- This instructions file
├── templates                         <-- Templates for the workshop
│   └── cloudformation                <-- Cloudformation templates for the workshop
│       └── pipeline-template.yaml    <-- Cloudformation templates for CodePipeline
├── code                              <-- Source code for the workshop
├── content                           <-- Website content for the workshop
└── deck                              <-- Presentation deck
```

## Requirements

* [Fork this repository](https://help.github.com/articles/fork-a-repo/) and create a [GitHub personal OAuth access token](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/)

## Instructions

[Installing the Sample Workshop in your AWS Account](#installing-the-sample-workshop-in-your-aws-account)

## Install the Sample Workshop in your AWS Account

1. Complete the [Requirements](#requirements)

2. Click on the CloudFormation Launch link below that corresponds to the AWS Region in which you want to deploy the workshop.

    [![US East (N. Virginia)](https://samdengler.github.io/cloudformation-launch-stack-button-svg/images/us-east-1.svg)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/create/review?stackName=aws-workshop-sample&templateURL=https://s3.amazonaws.com/aws-workshop-sample-us-east-1/pipeline-template.yaml&param_GitHubBranch=master&param_GitHubRepository=aws-workshop-sample)      


    ***Note:* You must use the new [CloudFormation Management Console](https://aws.amazon.com/about-aws/whats-new/2018/11/new-aws-cloudformation-management-console-now-available/) when creating the CloudFormation stack because the template uses the [CAPABILITY_AUTO_EXPAND](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_CreateStack.html) to install a [Nested Serverless Application](https://github.com/samdengler/codepipeline-s3-objects-public-read) to ensure Read Public access to the website S3 Objects.**

3. Once the CloudFormation **Quick create stack** page loads in your web browser, optionally update the **Stack name**.

4. Provide values for the following **Parameters**:

    | Parameter | Description |
    | --- | --- |
    | GitHubBranch | The branch on the forked GitHub Repository that will trigger the pipeline (defaults to **master**) |
    | GitHubOAuthToken | The [GitHub personal OAuth access token](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/) created in the [Requirements](#requirements) section |
    | GitHubRepository | The name of forked GitHub Repository (defaults to **aws-workshop-sample**) |
    | GitHubUsername | The GitHub username of the forked GitHub Repository |

5. Check the boxes for the following **Capabilities and transforms**:

    * **I acknowledge that AWS CloudFormation might create IAM resources.**
    * **I acknowledge that AWS CloudFormation might create IAM resources with custom names.**
    * **I acknowledge that AWS CloudFormation might require the following capability: CAPABILITY_AUTO_EXPAND**
    
6. Click the **Create stack** button.

7. Once the CloudFormation Stack has been created, click on the **Options** tab and note the value for **WebsiteURL**.

8. Paste the **WebsiteURL** into your web browser's URL address bar to visit the templated workshop website.

9. Congratulations!  You now have a working workshop website.
