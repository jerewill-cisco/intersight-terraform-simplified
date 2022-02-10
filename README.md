# A Study of Intersight in Terraform

## Introduction

In the work of the artist, a [Study](https://en.m.wikipedia.org/wiki/Study_(art)) is an important step on the journey to create a new piece of art.  It acts as a vehicle to help the artist understand the subject.  The effort yields fresh insights that inform the ultimate creation.

While certain arists may work in clay or acrylics, others work in Ansible or Terraform.  Or Python.  Or Go.

This study should help you understand the subject and provide you with new insights.

## Cisco UCS

The fundamental thing that always made Cisco UCS unique and interesting was the policy model.  Instead of configuring one server, you built a stack of policy that could configure 100.

Although the policy model in Intersight is simplified compared to the UCS Manager policy model, the fundamental approach remains the same.  And yet, all the details have changed.

## Intersight and Terraform

One of the unique strengths of Intersight is the logical alignment with Terraform.  The RESTful API using the Open API Spec lends itself to automatic conversion into a Terraform provider.  And that’s what we have at our disposal.

Keep the [Cisco Intersight Terraform Provider](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs) documentation close to hand.

The stacks of policy once held in UCS Manager, locked in each UCS Domain behind an XML API, are now exposed.

## Learn by Example

When approaching Intersight via Terraform, one is confronted with two simultaneously unfamiliar puzzles.  The first puzzle is Terraform itself, and there are many resources available to help acquire the basics there.  The second puzzle is Intersight.  Here again, there are many great resources.  If you have not yet been exposed to the [Intersight Handbook](https://cdn.intersight.com/components/an-hulk/1.0.9-931/docs/cloud/data/resources/Intersight-Handbook/en/Cisco_Intersight_Handbook.pdf), I have to recommend it immediately.

But there comes a point in the crawl, walk, run of learning when you want to see something that *already* works.  It helps to see the Terraform concepts that may have been taught to you using the AWS provider implemented using the Intersight provider.

That is the goal of this effort.

## Guiding Concepts

These goals guided the development of this code.

1. Simpler is better.  Complexity will be here soon enough.
1. No modules.  Modules are great.  But it’s easier to explain this code without them.
1. Few variables.  Variables are great.  And this repository uses them in places, but they are use sparingly to improve the ease of understanding.
1. One trick at a time.  There are nice Terraform tricks that allow us to do more with less code.  And this repository uses them in places, but in ways that are easier to understand because they are used in isolation instead of in a complex grouping.

## Using the Code

There are just three variables that you need to specify to deploy this code to Intersight.  See variables.tf for details.

Please select "API key for OpenAPI schema version 2" when you create the API key in Intersight.  See the [Intersight Documentation](https://intersight.com/apidocs/introduction/security/#generating-api-keys) for instructions.

Most of the files correspond directly to the names of the things in Interisight.  In most cases, any variables that are needed are specified right there in the same file.  The one big exception is the variables_network.tf which we use in a number of places.

## Onward

The right place for this code is in the lab.  It’s a solid choice to stand up an environment where further code will be developed.  It could be useful for Proof-of-Concept type activities or demonstrations.

The next logical place to go from here is something much more modular.  More complexity, more variables, more processed inputs, more reusable code.  More ready for production.

I would have to recommend that you take a look at

[terraform-intersight-easy-imm](https://github.com/terraform-cisco-modules/terraform-intersight-easy-imm)

And the other [Terraform code available from Cisco](https://github.com/terraform-cisco-modules).
