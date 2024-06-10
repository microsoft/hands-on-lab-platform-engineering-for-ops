---
published: true
type: workshop
title: Product Hands-on Lab - Platform engineering for Ops
short_title: Platform engineering for Ops
description: This workshop will cover the topic of platform engineering from an Ops perspective.
level: beginner # Required. Can be 'beginner', 'intermediate' or 'advanced'
navigation_numbering: false
authors: # Required. You can add as many authors as needed
  - Fethi Dilmi
  - Damien Aicheh
contacts: # Required. Must match the number of authors
  - "@fethidilmi"
  - "@damienaicheh"
duration_minutes: 180
tags: azure, dev center, azure deployment environment, microsoft dev box, azure policies, ops, csu
navigation_levels: 3
---

# Product Hands-on Lab - Platform engineering for Ops


## Prerequisites

Activate "Enable Catalog per projects"
![Enable Catalog per projects](assets/dev-center-enable-catalog-per-project.png)

## Lab 1
## Lab 2

### Manage a project
#### Create a projects

Create a project:

![Create a project](assets/dev-center-new-project.png)

Give a name that start with "prj-ops-" and then add your initials.
![New project](assets/project-new.png)

Notice in the Dev Box management panel that you can directly fix the number of Dev Boxes for this project.

Select **Yes** and then select the maximum number of Dev Boxests allow you to restrict how many dev boxes each developer can create in a project.

Set it to 5.

![Project max dev boxes](assets/project-new-max-dev-boxes.png)

Click on **Review + Create** and then **Create**.

After a few seconds, the project is created. Open it.

#### Assign an identity to the project

Go to the **Settings** tab and click on **Identity** and add a System Assigned Managed Identity:

![Project identity](assets/project-identity.png)

Wait for the identity to be created.

This will be used for...

#### Add an environment to the project

Link the environments available in the Dev Center to the project.

In your project, go to **Environment Configuration** and then **Environment Type**. In this section we will link the environments available in the Dev Center to the project. 

Click on **Add**, you will be redirected to a form where you can select the environment you want to link to the project.

You have 3 environments available:
- dev
- test
- prod

You can give to your users different permissions to each environment. Let's say that for this project you want to give the following permissions to your developers:
- In dev the `Owner` role
- In test the `Contributor` role
- In prod the `Reader` role

In fact...

So for each environment, select the role you want to give to your developers and click on **Add**.

![Project environment](assets/project-link-environment.png)

If everything is ok, you should see the environments linked to the project:

![Project environment linked](assets/project-environment-linked.png)

#### Add a catalog to the project

## Lab 3 