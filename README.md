![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=flat&logo=terraform&logoColor=white) [![published](https://static.production.devnetcloud.com/codeexchange/assets/images/devnet-published.svg)](https://developer.cisco.com/codeexchange/github/repo/jerewill-cisco/intersight-terraform-simplified)

# A Study of Intersight in Terraform

## Purpose

This code provides a simplified look at configuring Intersight via Terraform.  It works both as a set of coherent examples, and as a base for simple actives in a lab or learning environment.

## Introduction

In the work of the artist, a [Study](https://en.m.wikipedia.org/wiki/Study_(art)) is an important step on the journey to create a new piece of art.  It acts as a vehicle to help the artist understand the subject.  The effort yields fresh insights that inform the ultimate creation.

While certain artists may work in clay or acrylics, others work in Ansible or Terraform.  Or Python.  Or Go.

This study should help you understand the subject and provide you with new insights.

## Cisco UCS

The fundamental thing that always made Cisco UCS unique and interesting was the policy model.  Instead of configuring one server, you built a stack of policy that could configure 100.

Although the policy model in Intersight is simplified compared to the UCS Manager policy model, the fundamental approach remains the same.  And yet, all the details have changed.

## Intersight and Terraform

One of the unique strengths of Intersight is the logical alignment with Terraform.  The RESTful API using the Open API Spec lends itself to automatic conversion into a Terraform provider.  And that’s what we have at our disposal.

Keep the [Cisco Intersight Terraform Provider](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs) documentation close to hand.

The stacks of policy once held in UCS Manager, locked in each UCS Domain behind an XML API, are now exposed.

## Learn by Example

When approaching Intersight via Terraform, one is confronted with two simultaneously unfamiliar puzzles.  The first puzzle is Terraform itself, and there are many resources available to help acquire the basics there.  The second puzzle is Intersight.  Here again, there are many great resources.  If you have not yet been exposed to the [Intersight Handbook](https://cdn.intersight.com/components/an-hulk/1.0.9-974/docs/cloud/data/resources/Intersight-Handbook/en/Cisco_Intersight_Handbook.pdf), I have to recommend it immediately.

But there comes a point in the crawl, walk, run of learning when you want to see something that *already* works.  It helps to see the Terraform concepts that may have been taught to you using the AWS provider implemented using the Intersight provider.

That is the goal of this effort.

## Guiding Concepts

These goals guided the development of this code.

1. Simpler is better.  Complexity will be here soon enough.
1. No modules.  Modules are great.  But it’s easier to explain this code without them.
1. Few variables.  Variables are great.  And this repository uses them in places, but they are used sparingly to improve the ease of understanding.
1. One trick at a time.  There are nice Terraform tricks that allow us to do more with less code.  And this repository uses them in places, but in ways that are easier to understand because they are used in isolation instead of in a complex grouping.

## Lots of files

This repo organizes code into many files.  Although this may seem difficult at first, it makes it easier to use.  There are a few files that are common to many TF projects.

### [locals.tf](locals.tf)

This file is used to set some values that we use in a lot of places.  They can be thought of as "static variables" in some ways.  See [the language docs](https://www.terraform.io/language/values/locals) for more details.  This file has only a couple of values in it.  Typically, you wouldn't need to change them if you're just getting started.

One value, which we use on all the resources, is to build a tag called "Automation" that we set to "Terraform".  This tag is visible in Intersight to clearly mark the resources that we are creating with Terraform.  Ideally, you would only change those resources via Terraform and not via the UI.

The other value in locals selects the organization where we want to deploy our resources.  This isn't required by Intersight if your account only has the default organization.  But if multiple organizations do exist, we must specify the target organization.  Just to be safe, we're specifying the default organization.  See also [organization.tf](organization.tf)

### [providers.tf](providers.tf)

This file is used to tell Terraform which providers we intend to use and, in the case of Intersight, to configure them.

The `required_providers` block tells Terraform the minimum version of each provider that our code requires.  The `random` provider doesn't have any configuration, but the `intersight` provider does.  In the `intersight` block we retrieve the `apikey` and `secretkey` from variables.  See the [Required Variables](#required-variables) section for more details.

### [organization.tf](organization.tf)

In this file, we lookup the organization that already exists inside of your Intersight account.  To do that, we use a [Data Source](https://www.terraform.io/language/data-sources).  For simplicity, we use the `default` organization.

### Policy files

The code that becomes a policy in Intersight is organized into a file for each policy type.  They are named based on how the policy name is presented in the Intersight website.  This doesn't always correspond perfectly to the resource names in the API, so sometimes our Terraform resources have different names. For example, in [policy_boot_order.tf](policy_boot_order.tf) we use a resource type of `intersight_boot_precision_policy`.

Some policies, such as [policy_kvm.tf](policy_kvm.tf), only have one Terraform resource inside of them.  Some policies, such as [policy_imc_access.tf](policy_imc_access.tf) provide multiple examples of different policy options.  All of those resources correspond one-to-one with the policy in Intersight.  

Some policies, such as [policy_local_user.tf](policy_local_user.tf) or [policy_port.tf](policy_port.tf), are actually constructed from multiple resources.

### Pool files

The code that becomes a pool in Intersight is likewise organized into a file for each pool type in a way that is like the policy files above.  Most have multiple examples for different sized pools.

### Profile and Template files

Profiles aggregate the policy and pool objects into something that can be applied to equipment.  At least one example is provided for each type, and a server profile example is provided for FI Attached and Standalone targets in [profile_ucs_server.tf](profile_ucs_server.tf).

There is also one example Server Profile Template.  This template may be used from Intersight using the [Derive Profiles](https://intersight.com/help/saas/features/servers/operate#server_profile_templates) action.  While it is straightforward to create such templates from Terraform, it is not yet possible to use them from Terraform.

#### Server Profiles by Tag

In addition to the basic server profile example, a more complex example that combines an [intersight_search_search_item](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/search_search_item) data source and an [intersight_server_profile](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/server_profile) resource with a [for_each](https://www.terraform.io/language/meta-arguments/for_each) to provision multiple profiles is provided in [profile_ucs_server_by_tag.tf](profile_ucs_server_by_tag.tf).  Be aware that if you try to plan that terraform code and no servers are returned in the data source, it will cause the plan to (correctly) fail.

### Variables files

It is customary to define variables that are not "included" in the code using [variables.tf](variables.tf).  See the section below on [Required Variable](#required-variables).

Although many of our Terraform files include variables that help us create better code (see [pools_ip.tf](pools_ip.tf) for an example), this repo tries to keep the variables and the code that uses them together in the same file.  The big exception is variables_network.tf which is used in [policy_ethernet_network_group.tf](policy_ethernet_network_group.tf) and [policy_vlan.tf](policy_vlan.tf) among other places.

## Required Variables

There are just three input variables that you need to specify to deploy this code to Intersight.  

### If you are using the Terraform CLI

There are a couple of options for [assigning input variables](https://www.terraform.io/language/values/variables#assigning-values-to-root-module-variables), but using a .tfvars is the preferred way.

That file might look something like this...

```text
intersight-keyid = "ABCDEFGHIZJKMNOPQRSTUVWXYZ1234567890000"
intersight-secretkey = "insert your secret key here"
```

### If you are using a Terraform Cloud workspace

The most common way to specify these is by [creating workspace specific variables](https://www.terraform.io/cloud-docs/workspaces/variables/managing-variables#workspace-specific-variables).

### How to get API keys

You will need to have access to an Intersight account with at least one Essentials level license or higher.  Alternatively, you may use an evaluation license.  See the [Intersight Documentation](https://intersight.com/apidocs/introduction/security/#generating-api-keys) for instructions on creating the API key.  Please select "API key for OpenAPI schema version 2".  

## Running the code

If you are using the CLI, it's time to run ...

```text
terraform init
terraform plan
terraform apply
```

Or, if you are using Terraform Cloud, just click the "Actions" dropdown in your workspace and click "Start New Plan".

## Onward

The right place for this code is in the lab.  It’s a solid choice to stand up an environment where further code will be developed.  It could be useful for Proof-of-Concept type activities or demonstrations.

The next logical place to go from here is something much more modular.  More complexity, more variables, more processed inputs, more reusable code.  More ready for production.

I would have to recommend that you take a look at [terraform-intersight-easy-imm](https://github.com/terraform-cisco-modules/terraform-intersight-easy-imm) for a more modular approach to the same tasks.

And the other [repos available from this org on GitHub](https://github.com/orgs/terraform-cisco-modules/repositories).

And other Terraform code from the [Code Exchange at Cisco DEVNET](https://developer.cisco.com/codeexchange/explore#tech=Data%20Center&lang=Terraform).
