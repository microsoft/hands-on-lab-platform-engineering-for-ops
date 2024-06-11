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

GitHub Account

Create PAT
https://learn.microsoft.com/en-us/azure/deployment-environments/how-to-configure-catalog?tabs=GitHubRepoPAT#create-a-personal-access-token-in-github


Activate "Enable Catalog per projects"
![Enable Catalog per projects](assets/dev-center-enable-catalog-per-project.png)

## Lab 1



Inside the Dev Center, go to **Dev Box Definitions** and select **Create**

Create a new Dev Box definition with the following parameters:

- Name: `dev-box-ops-win-11-frontend-<your-initials>`
- Image: Pick a Visual Studio 2022 image with Windows 11
- Image version: `Latest`
- Compute size: `8 vCPUs, 32 GB RAM`
- Disk size: `256 GiB SSD`

And enable Hibernate mode, this will...

![Dev Box definition](assets/dev-center-dev-box-definitions-create.png)

Repeat the same steps to create a new Dev Box definition for the backend:

- Name: `dev-box-ops-win-11-backend-<your-initials>`
- Image: Pick a Visual Studio 2022 image with Windows 11
- Image version: `Latest`
- Compute size: `16 vCPUs, 64 GB RAM`
- Disk size: `512 GiB SSD`

You have now created two Dev Box definitions, one for the frontend and one for the backend.

![Dev Box definitions](assets/dev-center-dev-box-definitions.png)

### Create a project

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



#### Create Dev Box pools for the project

You can now assign the Dev Box definitions you created to the project. They will be used to create Dev Boxes for the developers.

Inside your project, go to **Dev Box Pools** and click on **Create**.

Start with the frontend one, give it the name `dev-box-ops-win-11-frontend-<your-initials>`  and select the Dev Box definition you created for the frontend.

For the network part, you can inject a Dev Box into a VNet but for this lab, we will keep it simple and use the default Microsoft Hosted network in `West Europe`


Select local administrator this will...

![Dev Box pool part 1](assets/project-dev-box-pool-part-1.png)

Then you have the ability to configure `Auto-stop` mode, this will...

![Dev Box pool part 2](assets/project-dev-box-pool-part-2.png)

Check the licence agreement and click on **Create**.

Repeat the same steps to create a Dev Box pool for the backend Dev Box definition.

You have now created two Dev Box pools, one for the frontend and one for the backend. The developers assigned to this project will be able to create Dev Boxes from these pools.

#### Autorized customizations

To enable the use of catalog items at the project definition:

In the project under **Settings**, select **Catalogs**. 

![Project enable catalog items](assets/project-enable-catalog-items.png)

In the **Catalog item settings** pane, select **Azure deployment environment definitions** to enable the use of environment definitions at the project level.

![Project enable catalog items validation](assets/project-enable-catalog-items-validation.png)

Now, you can add a catalog to the project.

Developers can customize their devboxes using yaml files such as:
```yaml
# https://github.com/microsoft/devcenter-catalog
# From https://github.com/microsoft/devcenter-examples
# Optionaly declare the devbox image to use 

$schema: 1.0
name: "devbox-customization"
tasks:
  - name: choco
    parameters:
      package: vscode

  - name: choco
    parameters:
      package: azd

  - name: git-clone
    description: Clone this repository into C:\Documents
    parameters:
      repositoryUrl: https://github.com/damienaicheh/dotnet-command-api.git
      directory: C:\Documents

  - name: powershell
    description: Install Azure Cli - Visual Studio Code extensions
    parameters:
      command: code --install-extension ms-vscode.azurecli

  - name: powershell
    description: Install Azure Dev Tools - Visual Studio Code extensions
    parameters:
      command: code --install-extension ms-azuretools.azure-dev

  - name: powershell
    description: Install Azure Dev Tools - Visual Studio Code extensions
    parameters:
      command: code --install-extension ms-vscode.vscode-node-azure-pack

# Other possibilities: winget, install-vs-extension   
```

You can control the different tasks that can be executed on the Dev Box by adding or not their definition in a catalog.

Official catalog are available here:

https://github.com/microsoft/devcenter-catalog in the `Tasks` folder
https://github.com/microsoft/devcenter-examples in the `advanced-examples` folder

You can pick the tasks you want and put it in your own company repository and then add it to the project as a catalog. 

In our case we have a catalog available at this location:

with the following tasks:

- choco
- customization-wsl
- download-ado-artifacts
- git-clone
- install-by-curl
- install-docker
- install-msi
- install-vs-extension
- powershell
- winget

Let's do this:

![Project add catalog](assets/project-add-dev-box-catalog.png)

Notice the `/` before the folder name `Tasks`, this is important to specify the folder where the catalog is located.

Then go to the resource group to retreive the Key Vault name. This will be used to retreive the secrets from the Key Vault. The Pat is located at this location:

```bash
https://<kv-name>.vault.azure.net/secrets/Pat
```

Click on **Add** and you should see the catalog added to the project with a status of `Sync Successful`.

Now, the developers assigned to this project will be able to use the tasks defined in the catalog to customize their Dev Boxes.

#### Test from a Developer perspective

Add the role `DevCenter DevBox User` to your self.

Go to the [Dev Box Portal][dev-box-portal] and sign in.

## Lab 2

### Manage a project

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

As you saw in the previous lab, you can add a catalog to a project to allow developers to customize their Dev Boxes.
However, catalog can also be used to define the Azure environments that will be available in the project. These catalogs are used by Azure Deployment Environment to create the environments using the same [portal][dev-box-portal] as the Dev Boxes.

You will use the sample catalog available at this location:

All the environments are defined in the `Environments` folder.

As you can see, you have 2 environments available:
- WebApp
- FunctionApp

Inside each folder you have:
- an `environment.yaml` file that defines the environment configuration
- an `azuredeploy.json` file that defines the ARM template to deploy the environment or a `main.bicep` file if you prefer to use Bicep
- an optional `ade.parameters.json` file if you need to pass parameters


You can also use Terraform and Pulumi to define your environments.

![Project Add Environment Catalog](assets/project-add-environment-catalog.png)

More examples are available in the [official catalog][ade-official-catalog]

#### Create a catalog 

Create your own catalog. In your own GitHub account, create a new repository and in an `CustomEnvironments` folder create an `Apim` folder the following files:

// ADD IMAGE

`environment.yaml`

```yaml
name: APIM
summary: This is an APIM deployment using Bicep.
description: Deploys an APIM using the Consumption Sku.
templatePath: main.bicep
parameters:
- id: name
  name: Name
  description: 'Name of the Apim'
  type: string
  required: true
runner: Bicep
```

// ADD IMAGE

`main.bicep`:

```bicep
@description('The name of the API Management service instance')
param name string = ''

var resourceName = !empty(name) ? replace(name, ' ', '-') : 'apim'

@description('Location for all resources.')
param location string = resourceGroup().location

resource apiManagementService 'Microsoft.ApiManagement/service@2023-05-01-preview' = {
  name:  'resourceName${uniqueString(resourceGroup().id)}'
  location: location
  sku: {
    name: 'Consumption'
    capacity: 0
  }
  properties: {
    publisherEmail: 'company@company.me'
    publisherName: 'Company'
  }
}
```

Of course the deployment can be more complex, with multiple bicep files and modules.

Now, you can add this catalog to the project in the same way you did for the Dev Box catalog.

#### In the Developer shoes

Add the role `Deployment Environments User` to your self.

Go to the [Dev Box Portal][dev-box-portal] and sign in.

![Dev Box Portal Environment Creation](assets/dev-box-portal-environment-created.png)

###  In the Ops / Admin shoes

Add the role `DevCenter Project Admin` to your self at the project level.

// Add Image of Environment tabs

You can see the associated cost for each deployment using the `View Cost` tab and potential advisor recommendations.

## Lab 3 


[dev-box-portal]: https://devbox.microsoft.com/
[ade-official-catalog]: https://github.com/Azure/deployment-environments