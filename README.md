# aws-workshop-sample

This project allows you to scaffold a workshop similar to those available at [](https://cdkworkshop.com/), [](https://eksworkshop.com/), or [](https://ecsworkshop.com/).

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

## Instructions



---

## Install the Sample Workshop in your AWS Account

[![US East (N. Virginia)](https://samdengler.github.io/cloudformation-launch-stack-button-svg/images/us-east-1.svg)](https://us-east-1.console.aws.amazon.com/cloudformation/home#/stacks/new?stackName=aws-workshop-sample&templateURL=https://s3.amazonaws.com/aws-workshop-sample-us-east-1/pipeline-template.yaml)
