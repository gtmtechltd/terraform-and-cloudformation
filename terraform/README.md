Terraform
=========

Contained within are terraform resources to create a minimal network and iam infrastructure in order to
run cloudformation templates against preexisting resources.

Different environments are represented as key=value stores in environments/ directory.

They can be named as either:

```
    environments/
        <environment>.<region>.tfvars    # an environment in a region
        <environment>.tfvars             # an environment in eu-west-1 (default region)
```

There are two "phases" to terraforming

* Bootstrap: Create minimal AWS Resources in order to support terraform itself. This only ever has to be done once
* Provision: Create and update AWS Resources for your target architecture.

These "phases" exist in directories `bootstrap/` and `provision/` respectively

The phase "bootstrap" is activated by the "bootstrap" keyword in the command `tf` (see below)

Running
=======

We run terraform with a local `tf` wrapper script which provides additional functionality not in the command.
The general format of the command is

```
     ./tf [bootstrap] <environment> <action> [flags]
e.g. ./tf             staging       plan 
```

Example to create production environment

* Configure environments/production.tfvars with variables, e.g the account_id
* Run

```
    ./tf bootstrap production plan
    ./tf production plan
```

Config Overview
===============

A guide to the layout of this repository:

```
    environments/              # environment specific configuration
        common.tfvars          # config common to all environments
        production.tfvars      # production config for region eu-west-1
        staging.tfvars         # staging config for region eu-west-1
    bootstrap/                 # terraform initial resources for bootstrap mode
    provision/                 # terraform initial resources for provision mode
    modules/                   # terraform modules code
```

Within bootstrap and provision, there is the following general layout:

```
    bootstrap|provision/
        .tfrc                  # helper variables which run for this phase.
        backend.tf             # configuration for the terraform engine and state
        main.tf                # terraform code calling out to other modules
        providers.tf           # configuration for the providers
        variables.tf           # defined variables which should exist in environments/*.tfvars
        state/                 # local state store for the bootstrap phase (optional)
```
